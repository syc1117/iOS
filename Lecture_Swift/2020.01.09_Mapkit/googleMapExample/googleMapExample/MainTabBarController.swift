//
//  MainTabBarController.swift
//  googleMapExample
//
//  Created by 신용철 on 2020/02/06.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = configureViewControllers()
    }
    
    func configureViewControllers() -> [UINavigationController] {
        
        let coordinateAddressNaviController = templateNaviController(unselectedImage: #imageLiteral(resourceName: "userd"), selectedImage: #imageLiteral(resourceName: "users"), rootViewController: CoordinatesAddressController())
        
        let AddressAutocompleteNaviController = templateNaviController(unselectedImage: #imageLiteral(resourceName: "homed"), selectedImage: #imageLiteral(resourceName: "homes"), rootViewController: AddressAutocompleteViewController())
        
        return [coordinateAddressNaviController, AddressAutocompleteNaviController]
    }
    
    func templateNaviController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        let naviController = UINavigationController(rootViewController: viewController)
        naviController.tabBarItem.image = unselectedImage
        naviController.tabBarItem.selectedImage = selectedImage
        
        return naviController
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = self.view.frame.size.height / 9
        tabFrame.origin.y = self.view.frame.size.height - 75
        tabBar.frame = tabFrame
    }
    
}
