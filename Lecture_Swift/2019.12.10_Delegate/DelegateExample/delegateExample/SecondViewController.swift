//
//  SecondViewController.swift
//  delegateExample
//
//  Created by 신용철 on 2020/02/07.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, DelegateFunc {
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
            print("----------SVCviewWillDisappear------------")
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
            print("----------SVCviewDidDisappear------------")
       }
    
  
    
    func sendTextField(_ word: String){
        
        self.label.text = word
    }
    
   var text = ""
    let label = UILabel()
    let dismissButton = UIButton(type: .system)
    
    weak var delegate2: DelegateFunc2?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         print("--------SVCviewWillAppear 함수실행----------")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("--------SVCviewDidLoad 함수실행----------")
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(dismissButton)
        (presentingViewController as! FirstViewController).delegate1 = self
        
        label.backgroundColor = .yellow
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = delegate2?.sendTextField()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.setTitleColor(.black, for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissTab), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        dismissButton.centerYAnchor.constraint(equalTo: label.centerYAnchor, constant: -100).isActive = true
    }
    
    @objc func dismissTab (){
        dismiss(animated: true)
    }
}


protocol DelegateFunc2: class {
    func sendTextField() -> String
}
