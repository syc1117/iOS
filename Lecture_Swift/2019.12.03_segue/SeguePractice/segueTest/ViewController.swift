//
//  ViewController.swift
//  segueTest
//
//  Created by 신용철 on 2019/12/09.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

//+1, +10 버튼 누르면 다음화면 라벨에 값 더해주기
//값이 50이 넘어가면 넘어가지 않도록 하기
//값이 50미만일때 다음버튼 누르면 10더해지고 50이 초과하면 1더해지도록 매뉴얼 세그 만들기
//텍스트필드에 값을 입력하면 그 값만큼 값 빼기


class ViewController: UIViewController {

    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func next(_ sender: Any) {
        if total > 50  {
            performSegue(withIdentifier: "one", sender: sender)
        } else {
            performSegue(withIdentifier: "ten", sender: sender)
        }
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        
        return total > 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super .prepare(for: segue, sender: sender)
    
        if segue.identifier == "one" {
            total += 1
        } else {
            total += 10
        }
        
        guard let nextVC = segue.destination as? NextViewController else { return }
        nextVC.total = self.total
    }
    
    @IBAction func unwindToFirstView(_ unwindSegue: UIStoryboardSegue) {
        guard let nvc = unwindSegue.source as? NextViewController else { return }
        self.total -= nvc.minus
        
    }
}

