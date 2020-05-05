//
//  MainViewController.swift
//  SignInPageExample
//
//  Created by 이봉원 on 11/11/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet private weak var userIdLabel: UILabel!
  var userId = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userIdLabel.text = userId
  }
  
  @IBAction private func didTapSignOutButton(_ sender: Any) {
    UserDefaults.standard.set(false, forKey: Key.isSignIn)
    UserDefaults.standard.set(nil, forKey: Key.userId)
    print("로그아웃 수행 - 로그인 정보 초기화")
    
    if let presenting = presentingViewController {
      presenting.dismiss(animated: true)
    } else {
      /***************************************************
       자동로그인 방법 (2) 를 통해 구현 시 dismiss 처리를 못하므로 window의 rootViewcontroller 이용
       ***************************************************/
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let signInVC = storyboard.instantiateInitialViewController()!
      let appDelegate = UIApplication.shared.delegate as? AppDelegate
      appDelegate?.window?.rootViewController = signInVC
    }
  }
}
