//
//  SecondViewController.swift
//  notification
//
//  Created by 신용철 on 2020/02/02.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
// MARK: name 등록 방법 3가지
//1) extension으로 Notification.Name 사용(swift 2.0 이전 방식)
extension Notification.Name {
    static let plustNotification = Notification.Name(rawValue: "plusNumber")
    static let randomColorNotification = Notification.Name(rawValue: "ChangeColor")
}

class SecondViewController: UIViewController {
    //3) 프로퍼티로 미리 선언해 놓고 사용하는 방식 (swift 4.2 이후 방식)
    static var plustNotification: Notification.Name {
        return Notification.Name(rawValue: "plusNumber")
    }
    static var randomColorNotification: Notification.Name {
        return Notification.Name(rawValue: "ChangeColor")
    }
    
    deinit {
        //self(해당viewController)에 들어있는 모든 옵저버를 삭제
        NotificationCenter.default.removeObserver(self)
        //self(해당viewController)에 들어있는 특정 옵저버를 삭제
        NotificationCenter.default.removeObserver(self, name: .randomColorNotification, object: nil)
    }
    
    let colorView = UIView()
    let numberLable = UILabel()
    let colorNotiButton = UIButton(type: .system)
    let plusNotiButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
         //2) 직접생성
        NotificationCenter.default.addObserver(self, selector: #selector(randomColor), name: Notification.Name("ChangeColor"), object: nil)
        //1) extension으로 Notification.Name을 시스템에 만들어서 사용
        NotificationCenter.default.addObserver(self, selector: #selector(plusNumber), name: .plustNotification, object: nil)
        
       
    }
    @objc func randomColor(_ sender: Notification){
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        colorView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
     @objc func plusNumber(_ sender: Notification){
        guard let number = Int(numberLable.text ?? "0") else { return }
        guard let userInfo = sender.userInfo as? [String: Int],
              let addValue = userInfo["값"]  else { return }
        numberLable.text = "\(number + addValue)"
    }
    
    @objc func didTouchPlusButton(_ sender: UIButton){
        //2번 방식
//        NotificationCenter.default.post(name: .plustNotification, object: sender)
        //userInfo를 통해 noti post할 때 특정 값들을 넘겨 줄 수 있음. 여기서는 5를 넘겨줌.
//        버튼(noti post) -> noti center 함수(selector)
        NotificationCenter.default.post(name: .plustNotification, object: sender, userInfo: ["값" : 5])
        
    }
    
    @objc func didTouchColorButton(_ sender: UIButton){
        //1번 방식
        let name = Notification.Name("ChangeColor")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
}

extension SecondViewController {
    func setupUI(){
        view.addSubview(colorView)
        view.addSubview(numberLable)
        view.addSubview(colorNotiButton)
        view.addSubview(plusNotiButton)
        
        

        // MARK: 각 object 속성값 설정
        colorView.backgroundColor = .green
        
        numberLable.text = "0"
        numberLable.textAlignment = .center
        numberLable.textColor = .black
        numberLable.font = UIFont.systemFont(ofSize: 30)
        
        colorNotiButton.setTitle("색상변경", for: .normal)
        colorNotiButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        colorNotiButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        colorNotiButton.setTitleColor(.blue, for: .normal)
        colorNotiButton.addTarget(self, action: #selector(didTouchColorButton), for: .touchUpInside)
        
        plusNotiButton.setTitle("숫자변경", for: .normal)
        plusNotiButton.setTitleColor(.blue, for: .normal)
        plusNotiButton.addTarget(self, action: #selector(didTouchPlusButton), for: .touchUpInside)
        
        
        // MARK: AutoLayout 설정
        [plusNotiButton, colorNotiButton, numberLable, colorView ].forEach{
                   $0.translatesAutoresizingMaskIntoConstraints = false
               }
        
        NSLayoutConstraint.activate([
        numberLable.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 30),
            numberLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        colorView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 100),
            colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 200),
            colorView.heightAnchor.constraint(equalToConstant: 200),
            
            colorNotiButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            colorNotiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            colorNotiButton.widthAnchor.constraint(equalToConstant: 50),
//            colorNotiButton.heightAnchor.constraint(equalToConstant: 50),

            plusNotiButton.topAnchor.constraint(equalTo: colorNotiButton.bottomAnchor, constant: 20),
            plusNotiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            plusNotiButton.widthAnchor.constraint(equalToConstant: 50),
//            plusNotiButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
