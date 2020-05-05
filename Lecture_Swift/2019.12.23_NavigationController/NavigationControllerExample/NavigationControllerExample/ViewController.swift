//
//  ViewController.swift
//  NavigationControllerExample
//
//  Created by 신용철 on 2019/12/25.
//  Copyright © 2019 신용철. All rights reserved.
//

//코딩으로 네비게이션 컨트롤러 세팅하기
//1. SceneDelegate로 가서 window 의 루트뷰를 네비게이션 컨트롤러로 설정.
//2. viewcontroller상의 네비게이션 바 아이템을 코딩으로 설정.

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "FirstVC" // 뷰컨트롤러가 기본적으로 가지고 있는 메서드. 이네비게이션 바 상의 타이틀 설정
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.prefersLargeTitles = true // title을 라지모드로 설정. iOS 11버전 이상만 지원됨. 네비게이션 컨트롤러 하위에 속한 모든 뷰컨트롤러에 적용
        navigationItem.largeTitleDisplayMode = .never //뷰 컨트롤러 별로 적용 여부 변경가능
        
        let rightBarButton = UIBarButtonItem(title: "next", style: .done, target: self, action: #selector(didTouch))
        navigationItem.rightBarButtonItem = rightBarButton
        let rightBarButton2 = UIBarButtonItem(title: "next2", style: .done, target: self, action: #selector(didTouch))
        navigationItem.rightBarButtonItem = rightBarButton2
        navigationItem.rightBarButtonItems = [rightBarButton, rightBarButton2] //배열로 한번에 여러개 추가하기
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTouch))
        //        navigationItem.leftBarButtonItem = leftBarButton
        let leftBarButton2 = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(didTouch))
        //        navigationItem.leftBarButtonItem = leftBarButton2
        navigationItem.leftBarButtonItems = [leftBarButton, leftBarButton2]
    }
    
    @objc private func didTouch(){
        let secondVC = SecondViewController()
        //        show(secondVC, sender: nil)
        navigationController?.pushViewController(secondVC, animated: true)
//        navigationController?.popViewController(animated: true) 는 뒤로가기. dismiss는 present에만 사용할 수 있음.
//        navigationController?.popToRootViewController(animated: true) // 최초화면으로 이동
    }
    
    //스토리보드 상에 만들어 놓은 것을 코딩에 반영하는 방법.
    //    override func viewDidAppear(_ animated: Bool) {
    //        viewDidAppear(animated)
    //
    ////        let storyboard = UIStoryboard(name: "Main", bundle: nil) //스토리보드를 인스턴스화. bundle은 왼쪽에 있는 파일들.
    ////        let secondVC = storyboard.instantiateViewController(identifier: "SecondViewController") as SecondViewController //코드 반영하고 자 하는 클래스로 연결
    ////
    ////        //화면 생성 방법들
    ////
    //////        show(secondVC, sender: nil) //좌측으로 나타남. 네비게이션 바 사용 가능함.
    //////        present(secondVC, animated: true) //아래에서 위로 나타남. 네비게이션 바 사용 불가.
    ////        navigationController?.pushViewController(secondVC, animated: true) //navigationcontroller를 사용할 때만 사용할 수 있음.
    //        //       navigationController?.popViewController(animated: true) 는 뒤로가기. dismiss는 present에만 사용할 수 있음.
    //        //       navigationController?.popToRootViewController(animated: true) // 최초화면으로 이동
    //
    //
    //    }
    
}

