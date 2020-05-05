//
//  ThirdViewController.swift
//  notificationStarter
//
//  Created by 신용철 on 2020/02/02.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

final class ThirdViewController: UIViewController {

  @IBOutlet private weak var titleTextField: UITextField!
  @IBOutlet private weak var timeIntervalLabel: UILabel!
  @IBOutlet private weak var minuteTextField: UITextField!
  @IBOutlet private weak var secondTextField: UITextField!
  
  let notiManger = UNNotificationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //app실행시 권한부여가 이루어진 상태면 참/ 아니면 거짓으로 isGranted에 값이 들어감.
    //UNNotificationManager에서 만들어 놓은 getNotificationSettings의 내용을 참고
    notiManger.getNotificationSettings { isGranted in
        if isGranted {
            // 권한이 부여되어있으므로 노티 발생 코드 작성
        } else {
            // 권한부여가 안되어 있으므로, Do nothing or 권한 허용 요청 Alert
        }
    }
  }
  
  
  @IBAction private func didEndOnExit(_ sender: UITextField) {
    resignFirstResponder()
    }
  
  var backupNumber = 0
  @IBAction private func editingChangedForCalendar(_ sender: UITextField) {
    guard let text = sender.text, !text.isEmpty, let number = Int(text) else { return }
    guard number < 60 else { return sender.text = String(backupNumber) }
    backupNumber = number
    sender.text = String(backupNumber)
  }
  
  @IBAction private func changeTimeInterval(_ sender: UIStepper) {
    timeIntervalLabel.text = String(Int(sender.value))
  }

  @IBAction private func triggerTimeIntervalNotification(_ sender: Any) {
    //noti에 들어갈 title 지정
    let title = titleTextField.text ?? ""
    let notificationTitle = title.isEmpty ? "Reminder" : title
    //noti에 들어갈 time 설정(time 후 작동) 여기서는 기본값 3초
    let timeInterval = TimeInterval(timeIntervalLabel.text!) ?? 3.0
    //noti 발생내용의 코드
    notiManger.triggerTimeIntervalNotification(
        with: notificationTitle, timeInterval: timeInterval)
  }
  
  
  @IBAction private func triggerCalendarNotification(_ sender: Any) {
    let title = titleTextField.text ?? ""
    let notificationTitle = title.isEmpty ? "Reminder" : title

    var dateComponents = DateComponents()
    dateComponents.calendar = Calendar.current
    //날짜, 시간까지는 current 속성을 가져오고, 분, 초만 설정.
    dateComponents.minute = Int(minuteTextField.text ?? "0") ?? 0
    dateComponents.second = Int(secondTextField.text ?? "0") ?? 0
    
    notiManger.triggerCalendarNotification(with: notificationTitle, dateComponents: dateComponents)
  }
}
