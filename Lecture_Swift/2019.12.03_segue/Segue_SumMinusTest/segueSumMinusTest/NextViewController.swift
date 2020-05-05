//
//  NextViewController.swift
//  segueSumMinusTest
//
//  Created by 신용철 on 2019/12/08.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    var total = 0
    var minus = 0
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBAction func textFeild(_ sender: UITextField) {
        if let minus = Int(sender.text!) {
            self.minus = minus
            numberLabel.text = "\(self.total - minus)"
    }
}
    @IBAction func backButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "\(total)"
    }
    

}
