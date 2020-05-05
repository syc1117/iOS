//
//  ViewController.swift
//  autoLayoutPractice
//
//  Created by 신용철 on 2019/12/18.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var centerXconstraint: NSLayoutConstraint!
    //***중요: constraint를 변수화해서 사용할 때 @IBOutlet으로 weak설정하면 isActive를 false로 지정하는 순간 아예 삭제되어 버려 다시는 활성화하여 사용할 수 없음. 따라서 weak으로 constraint를 사용하게 될 경우에는 반드시 isActivate를 신중하게 사용하여야 함.
    //*** 스토리보드와 weak에 대해서 IBOulet을 사용할 때 weak으로 설정되는 이유는 이미 스토리보드상에 객체가 생성되어 있기 때문에 중복되어 강한참조가 일어 날 수 있기 때문임.
    @IBOutlet weak var myView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        centerXconstraint = myView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centerXconstraint.isActive = true
        centerXconstraint.priority = .defaultHigh
    }
    
    var a = false
    @IBAction func toggle(_ sender: Any) {
        
        //view.setNeedsLayout() -> 레이아웃이 필요하다고 요청하는 매서드로 입력하면 true
        //시스템이 할거 다하고 해줄때 까지 기다려야함.
        //그러나 즉시 해주길 원한다면
        //view.layoutIfNeeded() -> setNeedsLayout이 true면 layout바로 수행해
        
        if a {
        UIView.animate(withDuration: 1, animations: {
            self.centerXconstraint.constant = 100 // view.setNeedsLayout() 실행하는 효과
            self.view.layoutIfNeeded()
        })
        }else {
            UIView.animate(withDuration: 1, animations: {
            self.centerXconstraint.constant = -100
                self.view.layoutIfNeeded()
                
            })
        }
        a.toggle() //안해주면 버튼 누를때 한번 움직이고 안움직임
    }
    
}

