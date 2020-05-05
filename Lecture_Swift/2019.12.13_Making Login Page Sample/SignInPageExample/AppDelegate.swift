//
//  AppDelegate.swift
//  SignInPageExample
//
//  Created by 이봉원 on 11/11/2019.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

struct Key {
  static let isSignIn = "IsSignIn"
  static let userId = ""
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    let isSignIn = UserDefaults.standard.bool(forKey: Key.isSignIn)
    if isSignIn {
      setupInitialViewController()
    }
    
    return true
  }
  
  
  func setupInitialViewController() {
    /***************************************************
     자동로그인 방법 (2) - window 의 루트뷰컨 교체
     ***************************************************/
    let userId = UserDefaults.standard.string(forKey: Key.userId) ?? ""
    print("자동로그인 수행 - 유저아이디 : \(userId)")
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
    (mainVC as! MainViewController).userId = userId
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.rootViewController = mainVC
    window?.makeKeyAndVisible()
  }
}
