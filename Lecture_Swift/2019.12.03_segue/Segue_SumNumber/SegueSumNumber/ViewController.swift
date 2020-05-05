//
//  ViewController.swift
//  SegueSumNumber
//
//  Created by 신용철 on 2019/12/03.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func manual(_ sender: Any) {
        //withIdentifier에는 실행하고자하는 segue의 identifier값을 입력함
        if count > 20 {
        performSegue(withIdentifier: "one", sender: sender)
        } else {
        performSegue(withIdentifier: "ten", sender: sender)
        }
        
    }
    
    @IBAction func unwindToViewController(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
        guard let nextVC = unwindSegue.source as? NextViewController else {
            return
        }
        count -= nextVC.minus
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        //슈퍼는 부모클래스의 해당 함수의 명령어를 실행할지 말지를 말하는 것인데, 그냥 다 붙어주는게 좋음. 역할을 할 수도 있기 때문에.
        
        let plus = identifier == "one" ? 1:10
        return count + plus < 40
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let nvc = segue.destination as? NextViewController else {
            return
        }
        
        if segue.identifier == "one" {
            count += 1
            nvc.text = count
            
        } else {
            count += 10
            nvc.text = count
        }
        
    }
    
   
    
}

