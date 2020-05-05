//
//  AppDelegate.swift
//  notificationStarter
//
//  Created by 신용철 on 2020/02/02.
//  Copyright © 2020 신용철. All rights reserved.
//


import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let notiManager = UNNotificationManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       //앱이 시작하자마자 noti가 날라오면 받을 수 있도록 함
        notiManager.register()
        
        return true
    }
}
