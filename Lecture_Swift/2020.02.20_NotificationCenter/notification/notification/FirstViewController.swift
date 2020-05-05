//
//  ViewController.swift
//  notification
//
//  Created by 신용철 on 2020/02/02.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    let textField = UITextField()
    
    // MARK: FirstViewController가 필요없어질 때 옵저버를 삭제하도록해야 함. 그 이유는 NotificationCenter.default 는 singlton이기 때문에 계속 살아 있기 때문임.
    deinit {
    //viewDidLoad에 notiCenter를 설치했다면 deinit에서, viewWillApear에서 생성 했을 경우에는 viewWillDisappear에서 removeObserver(self) 구현해야함.
    //viewWillApear에 noti를 구현하면 viewWillApear가 호출될 때마다 옵저버가 중첩되어 무한 생성되기 때문에 반드시 viewWillDisappear에서 제거해주어야 함.
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter()
        setupUI()
        textField.addTarget(self, action: #selector(textFiledSetting), for: .editingDidEndOnExit)
    }
    
    @objc func textFiledSetting(){
        resignFirstResponder()
    }
    
    // MARK: keyboard가 올라오고 내려갈 때 텍스트필드의 위치가 같이 이동하는 함수
    
     @objc func didBecomeActiveNoti (_ sender: Notification){
        print("didBecomeActiveNotification")
    }
}

extension FirstViewController {
    //viewDidLoad에 삽입
    func notificationCenter(){
        // MARK: keyboard가 나타날때 호출되는 noti
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(didReceiveKeyboardNoti),
                name: UIResponder.keyboardWillShowNotification,
                object: nil)
        // MARK: keyboard가 사라질때 호출되는 noti
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(didReceiveKeyboardNoti),
                name: UIResponder.keyboardWillHideNotification,
                object: nil)
        // MARK: app이 active상태가 될 때 호출되는 함수 - 공지사항등의 팝업창 생성시 사용
        NotificationCenter
        .default
            .addObserver(self,
                         selector: #selector(didReceiveKeyboardNoti),
                         name: UIApplication.didBecomeActiveNotification,
                         object: nil)
    }
    
    @objc func didReceiveKeyboardNoti (_ sender: Notification){
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = sender.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) {
            if keyboardFrame.minY >= self.view.frame.maxY {
                self.textField.frame.origin.y += keyboardFrame.height
            } else {
                self.textField.frame.origin.y -= keyboardFrame.height
            }
        }
    }
    
}

extension FirstViewController {
    func setupUI(){
        view.addSubview(textField)
        textField.borderStyle = .line
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
