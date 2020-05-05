//
//  AppDelegate.swift
//  AppLifeCycle
//
//  Created by 신용철 on 2020/02/08.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
//*************** iOS 10버전으로 Test할 때는 simulator를 iPhone 7버전으로 해야 적용됨.
//*************** iPhone 8버전부터 iOS 13버전으로 간주하고 SceneDelegate로 넘어감.
//*************** iOS 10버전과 13버전은 lifeCycle이 다르다.
//*************** iOS 10버전 : viewWillAppear와 viewDidAppear 사이에 아무것도 없음. 13버전에는 이 둘 사이에 in-active와 active 두 단계가 있음.
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(#function)
        if #available(iOS 13.0, *) {
            
        } else {
        print("10버전 window 생성")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
         print(#function)
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    //iOS 12 버전에서 호출 안됨
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
        //in-Active
    }
    //iOS 12 버전에서 호출 안됨
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
         //in-Active
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
    }
}

