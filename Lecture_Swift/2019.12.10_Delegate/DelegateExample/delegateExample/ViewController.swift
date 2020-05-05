//
//  ViewController.swift
//  delegateExample
//
//  Created by 신용철 on 2020/02/07.
//  Copyright © 2020 신용철. All rights reserved.
//기능 : 첫번째 화면에서 함수를 구현하고, 두번째에서 함수를 사용해가지고 두번째 화면에 있는 label에 값을 넣기

import UIKit

class FirstViewController: UIViewController, DelegateFunc2 {
    
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
            print("----------FVCviewWillDisappear------------")
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
            print("----------FVCviewDidDisappear------------")
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("----------FVCviewWillAppear------------")
    }
    
    
    let textField = UITextField()
    let button1 = UIButton(type: .system)
    let button2 = UIButton(type: .system)
    var word = ""
    
    weak var delegate1: DelegateFunc?
    
    func sendTextField() -> String{
        return self.textField.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        view.addSubview(button1)
        view.addSubview(button2)
        print("----------FVCviewDidLoad------------")
        textField.font = UIFont.systemFont(ofSize: 15) //
        textField.borderStyle = .roundedRect //모서리가 둥근 사각형
        textField.adjustsFontSizeToFitWidth = true //글자수 초과하면 글자수 작아짐(미니멈으로 설정한 데 까지)
        textField.clearsOnBeginEditing = true //편집시작하면 기존에 작성된 것 초기화
        textField.placeholder = "texField"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        textField.addTarget(self, action: #selector(putTextField), for: .editingChanged)
        
        button1.setTitle("Delegate1", for: .normal)
        button1.setTitleColor(.black, for: .normal)
        button1.addTarget(self, action: #selector(didTab1), for: .touchUpInside)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button1.centerYAnchor.constraint(equalTo: textField.centerYAnchor, constant: -100).isActive = true
        
        button2.setTitle("Delegate2", for: .normal)
        button2.setTitleColor(.black, for: .normal)
        button2.addTarget(self, action: #selector(didTab2), for: .touchUpInside)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button2.centerYAnchor.constraint(equalTo: button1.centerYAnchor, constant: 30).isActive = true
        
        
    }
    
    @objc func putTextField (_ sender: UITextField){
        
    }
    //왜 present 후에 델리게이트 함수를 실행시켜야되는가. 그냥 값을 너주면 되는데 함수로는 값이 안너어지는 현상
    @objc func didTab1(_ sender: UIButton) {
        let svc = SecondViewController()
        present(svc, animated: true)
        delegate1?.sendTextField(self.textField.text ?? "")
        
        
//        delegate1 = presentedViewController as! SecondViewController
       
    }
    
    @objc func didTab2() {
        let svc = SecondViewController()
        svc.delegate2 = self
        present(svc, animated: true)
    }
}

protocol DelegateFunc: class {
    func sendTextField(_ word: String) 
}
