//
//  SecondViewController.swift
//  dfffffff
//
//  Created by 신용철 on 2019/12/04.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var label = UILabel()
    let button = UIButton(type: .system)
    let button2 = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("2번화면 viewDidLoad")
        button.setTitle("뒤로", for: .normal)
        button.setTitleColor(.yellow, for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        button.addTarget(self, action: #selector(didTouch(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        button2.setTitle("다음", for: .normal)
        button2.setTitleColor(.yellow, for: .normal)
        button2.frame = CGRect(x: 200, y: 200, width: 100, height: 50)
        button2.addTarget(self, action: #selector(didTouch2(_:)), for: .touchUpInside)
        view.addSubview(button2)
        
        //        label.text = "기본"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.frame = CGRect(x: 200, y: 200, width: 200, height: 200)
        view.addSubview(label)
        
    }
    
    // MARK: 다음화면으로 이동(#2 -> #3)
    
    @objc func didTouch2(_ sender: UIButton){
        let thirdVC = ThirdViewController()
        print("2번화면 thirdVC 버튼클릭")
        thirdVC.label.text = "넘어감"
        thirdVC.modalPresentationStyle = .fullScreen
        thirdVC.view.backgroundColor = .green
        present(thirdVC, animated: true)
    }
    
    // MARK: 이전화면으로 이동(#2 -> #1)
    
    @objc func didTouch(_ sender: UIButton){
        print("2번화면 dismiss클릭")
        //presentingViewController: 나를 띄워준 화면 (1번 화면)
        //presentedViewController: 내가 띄워준 화면 (3번 화면)
        //presentingViewController는 UIViewController()이기 때문에 여기에 기본적으로 설정되어있는 property는 바로 접근이 가능함.
        //그러나 label과 같이 기본적으로 설정되어있지 않은 추가된 property에 대해서는 접근이 확실하지않기 때문에 타입캐스팅으로 접근하여야함. 이유는 옵셔널일 수 있기 때문에.
        //보충설명: UIViewController()에 이미 선언된 property의 경우에는 옵셔널일리가 없음. 따라서 타입캐스팅이 불필요. 그 변수는 분명하게 있기 때문임.
        presentingViewController?.view.backgroundColor = .yellow
        guard let firstVC = presentingViewController as? ViewController else { return }
        firstVC.label.text = "2번에서 수정함"
        dismiss(animated: true)
    }
    
    
    
    // MARK: 화면#2. viewLife Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("2번화면 viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("2번화면 viewWillDisappear")
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("2번화면 viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("2번화면 viewDidDisappear")
    }
}
