//
//  UserNotifacation.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/05.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import UserNotifications // iOS 10.0 버전 이후부터 쓸 수 있음.


final class UserNoti: NSObject {
    
    private let notiShared = UNUserNotificationCenter.current()
    
    func register() {
        notiShared.delegate = self
        let options: UNAuthorizationOptions = [.alert, .sound]
        notiShared.requestAuthorization(options: options) { (trueFalse, error) in
            guard trueFalse else { return self.goToSetting() }
            self.settingCategory()
        }
    }
    func getNotificationSettings(with completionHandler: @escaping (Bool) -> Void) {
        notiShared.getNotificationSettings { //권한부여가 되어 있는지 여부로 참 거짓 반환
            completionHandler($0.authorizationStatus == .authorized)
        }
    }
    
    private func goToSetting() {
        guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        DispatchQueue.main.async {
            UIApplication.shared.open(settingUrl)
        }
    }
    
    func settingCategory() {
        
        let okAction = UNNotificationAction(identifier: "ok", title: "확인", options: [])
        let category = UNNotificationCategory(identifier: "카테고리", actions: [okAction], intentIdentifiers:[])
        notiShared.setNotificationCategories([category])
    }
    
    
    func thisIsNoti(with title: String, timeInterval: TimeInterval = 3.0, imgUrl: URL) {
        
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "카테고리"
        content.sound = .default
        content.title = NSString.localizedUserNotificationString(forKey: "곡 추가 확인", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "플레이리스트에 ✨ \(title) ✨ 이(가) 추가되었습니다.", arguments: nil)
        
        
        content.badge = nil
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(
            identifier: "request",
            content: content,
            trigger: trigger)
        notiShared.add(request)
    }
}

extension UserNoti: UNUserNotificationCenterDelegate {
    // MARK: fore ground 상태에서 Noti 받았을 때 동작. 설정 안할 경우에는 앱이 background일 때만 noti가 동작함.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}


