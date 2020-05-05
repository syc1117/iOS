//
//  NextViewController.swift
//  SegueSumNumber
//
//  Created by 신용철 on 2019/12/03.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {


    @IBOutlet weak var number: UILabel!
    var text = 0
    var minus = 0
    
    
    @IBAction func editingChanged(_ sender: UITextField) {
        guard let a = Int(sender.text ?? "0") else {
           return
        }
        minus = a
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.number.text = "\(text)"
        print("viewdidload")
        
    }
    
}
