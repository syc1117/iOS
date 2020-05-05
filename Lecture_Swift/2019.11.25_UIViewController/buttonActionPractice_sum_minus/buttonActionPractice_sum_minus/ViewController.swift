//
//  ViewController.swift
//  buttonActionPractice_sum_minus
//
//  Created by 신용철 on 2019/11/27.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let Button = UIButton(type: .system)
    let label = UILabel()
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
    }

    @objc func didTouchPlus(_ sender: UIButton){
        let alert = UIAlertController(title: "연산", message: "연산하자", preferredStyle: .alert)
        let plusAction = UIAlertAction(title: "plus" , style: .default){ (action) in
            if let value = alert.textFields?.first?.text,
               let addValue = Int(value){
                self.number += addValue
                self.label.text = "\(self.number)"
            } else {
                self.number += 1
                self.label.text = "\(self.number)"
            }
        }
        let minusAction = UIAlertAction(title: "minus", style: .destructive){ (action) in
            self.number -= 1
            self.label.text = "\(self.number)"
        }
        let resetAction = UIAlertAction(title: "reset", style: .cancel){ (action) in
            self.number = 0
            self.label.text = "\(self.number)"
        }
        alert.addAction(plusAction)
        alert.addAction(minusAction)
        alert.addAction(resetAction)
        alert.addTextField{$0.placeholder = "정수 입력"}
        present(alert, animated: true)
        
       }
    
   
    
    func setupUI(){
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 15, weight: .black)
        label.frame = CGRect(x: 170, y: 100, width: 300, height: 50)
        view.addSubview(label)
        
        Button.setTitle("plus", for: .normal)
        Button.setTitleColor(.blue, for: .normal)
        Button.frame = CGRect(x: 150, y: 160, width: 100, height: 50)
        Button.addTarget(self, action: #selector(didTouchPlus), for: .touchUpInside)
        view.addSubview(Button)
        
       
    }
    
}

