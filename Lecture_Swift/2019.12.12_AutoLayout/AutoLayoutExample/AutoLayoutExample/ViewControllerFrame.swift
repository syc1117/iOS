//
//  ViewController.swift
//  AutoLayoutExample
//
//  Created by giftbot on 2019. 11. 30..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ViewControllerFrame: UIViewController {
  
  private let redView = UIView()
  private let blueView = UIView()
  
    override func viewDidLoad() {
    
    super.viewDidLoad()
    redView.backgroundColor = .red
    view.addSubview(redView)
    
    blueView.backgroundColor = .blue
    view.addSubview(blueView)
    
    print("statusBarFrame :", UIApplication.shared.statusBarFrame)
    
    // (0,0,0,0) top, left, bottom, right
    print("viewDidLoad :", view.safeAreaInsets)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear :", view.safeAreaInsets)
    // (0,0,0,0)
  }
  
  override func viewSafeAreaInsetsDidChange() {
    super.viewSafeAreaInsetsDidChange()
    print("viewSafeAreaInsetsDidChange :", view.safeAreaInsets)
    // iPhone8 (20, 0, 0, 0)
    // iPhoneX 시리즈 (44, 0, 34, 0)
  }
  
  /***************************************************
   viewWillAppear
     -> viewSafeAreaInsetsDidChange : safe area 생성되는 단계
     -> viewWillLayoutSubviews : 루트뷰의 하위 뷰들이 나타나기 전
     -> viewDidLayoutSubviews : 루트뷰의 하위 뷰들이 나타난 후
     -> viewDidAppear
   ***************************************************/
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    
    let margin: CGFloat = 20
    let padding: CGFloat = 10
    let safeLayoutInsets = view.safeAreaInsets
    let horizontalInset = safeLayoutInsets.left + safeLayoutInsets.right
    
    let yOffset = safeLayoutInsets.top + margin //44 + 20
    let viewWidth = (view.frame.width - padding - horizontalInset - margin * 2) / 2
    
    redView.frame = CGRect(
      x: safeLayoutInsets.left + margin,
      y: yOffset,
      width: viewWidth,
      height: view.bounds.height - yOffset - (safeLayoutInsets.bottom + margin)
    )
    
    blueView.frame = CGRect(
      origin: CGPoint(x: redView.frame.maxX + padding, y: yOffset),
      size: redView.bounds.size
    )
  }
}

