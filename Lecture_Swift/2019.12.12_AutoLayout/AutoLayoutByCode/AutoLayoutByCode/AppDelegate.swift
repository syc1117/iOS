//
//  AppDelegate.swift
//  AutoLayoutByCode
//
//  Created by giftbot on 2019. 12. 10..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupKeyWindow()
    return true
  }
  
  func setupKeyWindow() {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
  }
}
