//
//  AppDelegate.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/01/24.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if #available(iOS 13.0, *) {
            
        } else {
            window = UIWindow(frame: UIScreen.main.bounds) //기기의 종류와 상관없이 화면에 여백없이 꽉채우기 위함
            window?.backgroundColor = .white // 기본값이 검은배경으로 되어 있어서 흰색으로 설정해주는 것임.
            window?.rootViewController = UINavigationController(rootViewController: MainViewController()) //window에서 viewController()를 사용하기 위해 컨트롤러를 설정해줌. 이때 쓰는 것이 rootViewController
            window?.makeKeyAndVisible()
            
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
        
    }
}

