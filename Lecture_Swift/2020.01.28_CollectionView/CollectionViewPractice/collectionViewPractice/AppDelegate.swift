//
//  AppDelegate.swift
//  collectionViewPractice
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            
        } else {
            let ccv = UINavigationController(rootViewController: CustomCellViewController())
            let svc = UINavigationController(rootViewController: SectionViewController())
            let fvc = UINavigationController(rootViewController: FlexibleViewController())
            
            ccv.tabBarItem = UITabBarItem(title: "ccv", image: .actions, tag: 0)
            svc.tabBarItem = UITabBarItem(title: "svc", image: .checkmark, tag: 0)
            fvc.tabBarItem = UITabBarItem(title: "fvc", image: .strokedCheckmark, tag: 0)
            
            let tabbarController = UITabBarController()
            tabbarController.viewControllers = [ccv, svc, fvc]
            
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = tabbarController
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

