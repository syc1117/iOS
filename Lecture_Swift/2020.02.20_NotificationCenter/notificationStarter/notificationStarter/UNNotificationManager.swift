//
//  UNNotificationManager.swift
//  notificationStarter
//
//  Created by 신용철 on 2020/02/02.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import UserNotifications // iOS 10.0 버전 이후부터 쓸 수 있음.


final class UNNotificationManager: NSObject {
  enum Identifier {
    static let basicCategory = "BasicCategory"
    static let anotherCategory = "AnotherCategory"
    
    static let timeIntervalRequest = "TimeIntervalRequest"
    static let calendarRequest = "CanlendarRequest"
    
    static let repeatAction = "RepeatAction"
    static let removeAction = "RemoveAction"
    static let textInputAction = "TextInputAction"
  }
    //UNUserNotificationCenter의 싱글턴
    private let center = UNUserNotificationCenter.current()
  
    //AppDelegate.swift 파일에서 호출(앱 실행하면 바로 호출되도록 함.)
  func register() {
    center.delegate = self
    //.alert, .badge, .sound 에 대하여 권한을 받는 alert 띄움.
    let options: UNAuthorizationOptions = [.alert, .badge, .sound]
    center.requestAuthorization(options: options) { (isGranted, error) in
        guard isGranted else { //isGranted: 권한 부여 되었는지 확인
            print("No Granted")
            print(error?.localizedDescription ?? "")
            //권한 부여 안되었으면 설정창으로 이동시킴
            return self.requestAlertNotification()
        }
        print("Granted")
        self.setupNotificationCategories()
    }
  }
    //앱 시작할때가 아닌 각 viewController에서 권한 설정여부를 묻는 alert를 띄우는 방법
    func getNotificationSettings(with completionHandler: @escaping (Bool) -> Void) {
        center.getNotificationSettings { //권한부여가 되어 있는지 여부로 참 거짓 반환
            completionHandler($0.authorizationStatus == .authorized)
        }
    }
    
    private func requestAlertNotification() {
        //register()에서 Noti 권한부여 안되었을 시 설정창으로 이동하는 함수
        guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        DispatchQueue.main.async {
            UIApplication.shared.open(settingUrl)
        }
    }
    
    

  
  /***************************************************
   SetupNotificationCategories
   ***************************************************/
  //Noti의 카테고리 지정하는 함수
    func setupNotificationCategories() {
        //코딩 구조: UNNotificationAction을 정의해서 UNNotificationCategory의 actions에 추가 한 후, setNotificationCategories으로 설정
        //작동 원리: Noti를 날릴 때 어떤 categories에 해당하는 것인지를 설정할 수 있는 데 이 때 설정해 둔 해당 categories의 Action버튼이 달리게 되는 개념으로 alertController와 alertAction의 관계와 매우 유사함.
        //여기서는 noti에 액션 버튼 추가만 하고 action이 클릭 되었을 때 무슨 기능을 실행할 것인지는 아래 delegate의 didReceive response 함수에서 코딩함.
        let repeatAction = UNNotificationAction(
            identifier: Identifier.repeatAction,
            title: "Repeat",
            options: []
        )
        let basicCategory = UNNotificationCategory(
            identifier: Identifier.basicCategory,
            actions: [repeatAction],
            intentIdentifiers: []
        )
        //    center.setNotificationCategories([basicCategory])
        
        /***************************************************
         - UNNotificationActionOptions
         .foreground : 버튼 눌렀을 때 앱을 실행하도록 함
         .destructive : delete, remove 등 주의해야 하는 작업에 적용
         .authenticationRequired : 디바이스 락이 걸린 상태로 사용 못 하도록 함
         ***************************************************/
        
        let removeAction = UNNotificationAction(
            identifier: Identifier.removeAction,
            title: "Remove",
            options: [.destructive, .foreground]
        )
        
        let textInputAction = UNTextInputNotificationAction(
            identifier: Identifier.textInputAction,
            title: "Change Title",
            options: [.authenticationRequired],
            textInputButtonTitle: "Save",
            textInputPlaceholder: "Repeat with input message"
        )
        
        let anotherCategory = UNNotificationCategory(
            identifier: Identifier.anotherCategory,
            actions: [removeAction, textInputAction],
            intentIdentifiers: [],
            options: [.customDismissAction]
        )
        center.setNotificationCategories(
            [basicCategory, anotherCategory]
        )
    }
  
  
  
  /***************************************************
   TimeIntervalNotification - TimeInterval로 지정한 시간(초) 이후로 알림 등록
   ***************************************************/
  //유저 노티 설정
  func triggerTimeIntervalNotification(with title: String, timeInterval: TimeInterval = 3.0) {
    /*
     UNMutableNotificationContent()에 각종 속성 값들(제목, 내용, 이미지 첨부, 알림소리 설정 등)과 UNTimeIntervalNotificationTrigger(몇 초후 noti할 것인지)를 정의한 후에
     UNNotificationRequest에 위 둘을 첨가하여 UNUserNotificationCenter.current()에 add시킨다.
     
     */
    let content = UNMutableNotificationContent()
//    content.categoryIdentifier = Identifier.basicCategory
    //설정한 카테고리 중 원하는 형태를 추가하여 추가기능 부여(확인 버튼 등)
    content.categoryIdentifier = Identifier.anotherCategory
    //알림의 제목 설정
    content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
    //알림의 내용 설정
    content.body = NSString.localizedUserNotificationString(forKey: "Alarm fired", arguments: nil)
    
    // Image 추가: 소리, 영상도 가능함
    if let imageUrl = Bundle.main.url(forResource: "IU", withExtension: "png") {
        let attachment = try! UNNotificationAttachment(identifier: "attachmentImage", url: imageUrl)
        content.attachments = [attachment]
    }
    
    // Badge: 설정 1로 하면 노티 발생후에 앱에 1이라고 빨간 동그라미 붙음
    content.badge = nil   // nil or 0
    
    // sound 추가: 미설정 시 사운드 x
    let soundName = UNNotificationSoundName(rawValue: "sweetalertsound4.wav")
    content.sound = UNNotificationSound(named: soundName)
//    content.sound = UNNotificationSound.default
    

   // 이벤트 발생 후 몇초 후에 noti 발생시킬 것인지
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
    // repeats = 60초 이상만 설정 가능. 설정한 시간에 한번식 노티가 반복적으로 날라감.
    // noti 완성
    let request = UNNotificationRequest(
        identifier: Identifier.timeIntervalRequest,
        content: content,
        trigger: trigger)
    //add하면 add된 순간부터 trigger초 후에 noti발생함.
    center.add(request)
}
  
  
  
  /***************************************************
   CalendarNotification - 특정 날짜/시간을 지정하여 알림 등록
   ***************************************************/
  
  func triggerCalendarNotification(with title: String, dateComponents: DateComponents) {
    let content = UNMutableNotificationContent()
    content.categoryIdentifier = Identifier.basicCategory
    content.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
    content.body = NSString.localizedUserNotificationString(forKey: "Alarm fired", arguments: nil)
    content.sound = .default
    content.userInfo = ["Name": "Chunsu"]
    
    //여기서 추가한 sound는 noti알람음이 아님. 재생눌러서 실행할 수 있는 음악파일이 뜸.
    if let soundURL = Bundle.main.url(forResource: "pup-alert", withExtension: "mp3") {
        let soundAttachment = try! UNNotificationAttachment(
            identifier: "SoundAttachment", url: soundURL
        )
        content.attachments = [soundAttachment]
    }
    
    let trigger = UNCalendarNotificationTrigger(
        dateMatching: dateComponents,
        repeats: false
    )
    let request = UNNotificationRequest(
        identifier: Identifier.calendarRequest,
        content: content,
        trigger: trigger
    )
    center.add(request)
    }
}

extension UNNotificationManager: UNUserNotificationCenterDelegate {
    
    // MARK: noti를 클릭했을 때 호출되는 함수
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //didReceive response를 통해 content에 접근할 수 있고 그 안의 속성값인 categoryIdentifier에 접근할 수 있음.
        let content = response.notification.request.content
        let categoryID = content.categoryIdentifier
        
        //categoryIdentifier 에 따른 작동코드를 다르게 구현 할 수 있음
        if categoryID == Identifier.basicCategory {
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                //app밖으로 나와있을 때 noti 클릭하면 app으로 들어오는 기본기능을 수행함.
                print("Tap Notification")
            case Identifier.repeatAction:
                //추가한 action버튼 클릭시 호출됨. 여기서는 Reminder 타이틀로 noti 재실행하는 함수를 넣어놨음
                print("Repeat Action")
                triggerTimeIntervalNotification(with: "Reminder")
            default:
                print("Unknown action")
            }
        } else if categoryID == Identifier.anotherCategory {
            switch response.actionIdentifier {
            case UNNotificationDismissActionIdentifier:
                //noti를 제거하면 호출
                print("Dismiss Notification")
            case Identifier.removeAction:
                print("Remove Action")
                // Remove some data
            case Identifier.textInputAction:
                print("textInputAction")
                if let inputResponse = response as? UNTextInputNotificationResponse {
                    triggerTimeIntervalNotification(with: inputResponse.userText)
                }
            default:
                print("Unknown Action")
            }
        }
        
        completionHandler()
    }
    // MARK: fore ground 상태에서 Noti 받았을 때 동작. 설정 안할 경우에는 앱이 background일 때만 noti가 동작함.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //앱 실행중이어도 .alert, .sound를 noti하겠다는 것.
        completionHandler([.alert, .sound])
    }
}

