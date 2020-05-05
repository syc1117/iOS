//
//  SecondViewController.swift
//  1203SegueLecture
//
//  Created by 신용철 on 2019/12/03.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func unwindToSecondViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let thirdVC = segue.destination as? ThirdViewController else { return
            }
        
        if segue.identifier == "card" {
            thirdVC.text = "card"
        } else  {
            thirdVC.text = "fullScreen"
        }
        
    }
    
    
}
