//
//  SceneDelegate.swift
//  collectionViewStarter
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let ccc = UINavigationController(rootViewController:  CustomCellViewController())
        ccc.tabBarItem = UITabBarItem(title: "ccc", image: .none, tag: 0)
        let svc = UINavigationController(rootViewController: SectionViewController())
        svc.tabBarItem = UITabBarItem(title: "svc", image: .none, tag: 0)
        let fvc = UINavigationController(rootViewController: FlexibleViewController()) 
        fvc.tabBarItem = UITabBarItem(title: "fvc", image: .none, tag: 0)
        
        let tabbarC = UITabBarController()
        tabbarC.viewControllers = [ccc, svc, fvc]
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabbarC
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    func sceneWillResignActive(_ scene: UIScene) {
      
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

