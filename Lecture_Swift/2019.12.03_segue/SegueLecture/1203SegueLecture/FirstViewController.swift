//
//  ViewController.swift
//  1203SegueLecture
//
//  Created by 신용철 on 2019/12/03.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func unwindToFisrtViewController(_ unwindSegue: UIStoryboardSegue) {

        guard let sourceViewController = unwindSegue.source as? SecondViewController else { return }
        
        sourceViewController.view.backgroundColor = .black
        
    }

}
