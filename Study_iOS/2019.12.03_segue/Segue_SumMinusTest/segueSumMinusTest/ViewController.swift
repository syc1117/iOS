//
//  ViewController.swift
//  segueSumMinusTest
//
//  Created by 신용철 on 2019/12/08.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var total = 0
   
    @IBAction func tenPlus(_ sender: Any) {
//        total += 10
    }
 
    @IBAction func onePlus(_ sender: Any) {
//        total += 1
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if total > 50 {
        performSegue(withIdentifier: "one", sender: sender)
        } else {
        performSegue(withIdentifier: "ten", sender: sender)
//
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func unwindToFirstView(_ unwindSegue: UIStoryboardSegue) {
        guard let nvc = unwindSegue.source as? NextViewController else { return }
       
        self.total -= nvc.minus
        
        
        
    }

//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
//
//        return self.total < 50
//    }
    
    //segue실행될 시 다음화면에 객체값 변경
    //NextViewController의 total 값에 값 넘겨주기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "one" {
            total += 1
        } else {
            total += 10
        }
        
        guard let nextVC = segue.destination as? NextViewController else { return }
        nextVC.total = self.total

    }
}

