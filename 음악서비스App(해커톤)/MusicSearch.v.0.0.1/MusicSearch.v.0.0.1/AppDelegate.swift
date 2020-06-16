//
//  AppDelegate.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/03.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
 let notiManager = UserNoti()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        notiManager.register()
        
        if #available(iOS 13.0, *) {
            
        } else {
            
            let tabbarController = UITabBarController()
            let mvc = MainViewController()
            let svc = SearchViewController()
            let mpc = MyPlayListViewController()
            mvc.tabBarItem = UITabBarItem(title: "Home", image: .some(UIImage(named: "홈")!), tag: 0)
            svc.tabBarItem = UITabBarItem(title: "Search", image: .some(UIImage(named: "서치")!), tag: 1)
            mpc.tabBarItem = UITabBarItem(title: "PlayList", image: .some(UIImage(named: "보관함")!), tag: 2)
            
            tabbarController.viewControllers = [mvc, svc, mpc]
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = tabbarController
            window?.backgroundColor = .white
            window?.makeKeyAndVisible()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }



}

