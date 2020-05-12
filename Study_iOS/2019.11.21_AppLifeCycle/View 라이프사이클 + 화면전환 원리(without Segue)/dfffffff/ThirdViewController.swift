//
//  ThirdViewController.swift
//  dfffffff
//
//  Created by 신용철 on 2019/12/04.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    let button = UIButton(type: .system)
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("3번화면 viewDidLoad")
        button.setTitle("뒤로가기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.addTarget(self, action: #selector(didTouch(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
        view.addSubview(label)
    }
    
    // MARK: 이전화면으로 이동(#3 -> #2)
    
    @objc func didTouch(_ sender: UIButton){
        print("3번화면 dismiss클릭")
        dismiss(animated: true)
        
        
        
    }
    
    // MARK: 화면#3. viewLife Cycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("3번화면 viewWillDisappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("3번화면 viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("3번화면 viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("3번화면 viewDidDisappear")
    }
}
