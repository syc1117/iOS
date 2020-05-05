//
//  SceneDelegate.swift
//  TabBar
//
//  Created by 신용철 on 2019/12/25.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
        
        func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }
//
//            let firstVC = ViewController()
//            let secondVC = SecondViewController()
//            let thirdVC = ThirdViewController()
//            firstVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "person.circle"), tag: 0)
//            secondVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "folder.fill"), tag: 1)
//            thirdVC.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "paperplane"), tag: 2)
//            let tabBarController = UITabBarController()
//            tabBarController.viewControllers = [firstVC, secondVC, thirdVC]
//
//            let window = UIWindow(windowScene: windowScene)
//            window.rootViewController = tabBarController
//            window.backgroundColor = .systemBackground
//            window.makeKeyAndVisible()
//            self.window = window
            
            //navigationController를 같이 사용하고 싶을 경우 아래와같이
            //네비 컨트롤러에 firstVC 넣고 네비 컨트롤러를 firstVC에 넣어줌.
            
            let firstVC = ViewController()
            let secondVC = SecondViewController()
            let thirdVC = ThirdViewController()
            
            let navigation = UINavigationController(rootViewController: firstVC)
            firstVC.title = "FirstVC"
            secondVC.title = "secondVC"
            thirdVC.title = "thirdVC"
            
             
            navigation.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "person.circle"), tag: 0)
            secondVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "folder.fill"), tag: 1)
            thirdVC.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "paperplane"), tag: 2)
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [navigation, secondVC, thirdVC]
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = tabBarController
            window.backgroundColor = .systemBackground
            window.makeKeyAndVisible()
            self.window = window
            
        }
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

