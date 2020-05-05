//
//  NextViewController.swift
//  segueTest
//
//  Created by 신용철 on 2019/12/09.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var numberLabel: UILabel!
    var total = 0
    var minus = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        numberLabel.text = "\(total)"
       
    }

    @IBAction func textField(_ sender: UITextField) {
        minus = Int(sender.text ?? "0") ?? 0
        numberLabel.text = "\(total - minus)"
    }
    
}
