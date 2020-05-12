//
//  ViewController.swift
//  DelegateTextField
//
//  Created by 신용철 on 2019/12/10.
//  Copyright © 2019 신용철. All rights reserved.
//


//TextField 에 입력한 후 엔터를 누르면 색상으로 view의 배경색깔이 변하도록
//red black blue의 경우만 제대로 바뀌고 나머지는 gray로 바꿀 것
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
    }
    
    
}

//더 많은 기능, 더 편한 커스터마이징을 위해 델리게이트를 사용함.
extension ViewController: UITextFieldDelegate {
    //prefer trigger와 같은 기능
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "black" {
           myView.backgroundColor = .black
        } else if textField.text == "blue" {
             myView.backgroundColor = .blue
        } else if textField.text == "red" {
           myView.backgroundColor = .red
        } else {
             myView.backgroundColor = .gray
        }
        return true
    }
}
