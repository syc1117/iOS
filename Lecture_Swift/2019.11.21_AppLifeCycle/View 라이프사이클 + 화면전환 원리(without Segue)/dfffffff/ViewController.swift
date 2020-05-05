//
//  ViewController.swift
//  dfffffff
//
//  Created by 신용철 on 2019/12/04.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

/*  학습목표 *
 
 1. 화면 전환시 view lifecycle을 이해할 수 있다.
 - full screen 상태일때와 card형일 때 라이프 사이클의 차이를 알 수 있다.
 
 2. segue를 이용하지 않고 present와 dismiss로 화면을 추가하고 없앨 수 있다.
 
 3. 전환 될 화면의 object들의 속성값을 변경할 수 있다.
 - 다음화면: 인스턴스 생성으로 화면을 생성하는 원리를 알고 해당 인스턴스의 object에 접근한다
 - 이전화면: 커스터마이징 한 object에 한하여 타입캐스팅을 통해 접근하여 object에 접근한다.
 UIViewController()에 기본적으로 설정된 object는 presentingViewController로 접근이 가능함.
 - 접근자: presentingViewController와 presentedViewController의 차이를 이해한다.
 - 타입캐스팅을 해야하는 이유과 그 원리를 이해한다.
 */



class ViewController: UIViewController {
    
    let button = UIButton(type: .system)
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "기본"
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.frame = CGRect(x: 100, y: 300, width: 300, height: 100)
        view.addSubview(label)
        
        print("1번화면 viewDidLoad")
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.addTarget(self, action: #selector(didTouch(_:)), for: .touchUpInside)
        view.addSubview(button)
        
    }
    
    // MARK: 다음화면으로 이동(#1 -> #2)
    
    @objc func didTouch(_ sender: UIButton){
        let secondVC = SecondViewController()
        print("1번화면 secondVC 버튼클릭")
        secondVC.label.text = "넘어감"
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.view.backgroundColor = .red
        present(secondVC, animated: true)
    }
    
    // MARK: 화면#1. viewLife Cycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("1번화면 viewWillDisappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("1번화면 viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("1번화면 viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        print("1번화면 viewDidDisappear")
    }
}

