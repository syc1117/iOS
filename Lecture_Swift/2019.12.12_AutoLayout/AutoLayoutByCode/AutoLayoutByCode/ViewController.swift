//
//  ViewController.swift
//  AutoLayoutByCode
//
//  Created by giftbot on 2019. 12. 10..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  private let firstView = UIView()
  private let secondView = UIView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    firstView.backgroundColor = .darkGray
    view.addSubview(firstView)
    secondView.backgroundColor = .green
    firstView.addSubview(secondView)
    
    setupAutoresizingMask()
//    activateLayoutAnchors()
    
    // NSLayoutConstraint, VisualFormat 참고용
//    activateNSLayoutConstraintConstraints() 별로 안중요. 완전 구버전씩 오토레이아웃 포맷.
//    activateVisualFormat() 별로 안중요
  }
  
  private func setupAutoresizingMask() {
    // flexibleWidth
    // flexibleHeight
    // flexibleTopMargin
    // flexibleLeftMargin
    // flexibleRightMargin
    // flexibleBottomMargin
    
    firstView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    secondView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    firstView.frame = CGRect(
      x: 50, y: 100,
      width: 150, height: 200
    )
    secondView.frame = CGRect(
      x: 50, y: 50,
      width: 80, height: 80
    )
    
    // 수퍼뷰의 크기가 변했을 때 서브뷰의 변화 확인
//    firstView.frame.size.width = 250
    firstView.frame.size.height = 400
  }
  

  private func activateLayoutAnchors() {
    /***************************************************
     iOS 9.0 이상에서 사용 가능
     
     view.topAnchor - 뷰에 설정 시
     view.safeAreaLayoutGuide.topAnchor - SafeArea에 설정 시
     ***************************************************/
    
    
    // isActive를 통한 제약조건 활성화
    firstView.translatesAutoresizingMaskIntoConstraints = false //************오토리사이징마스크 비활성화, 오토레이아웃사용할때 반드시 해야됨.
    firstView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
    firstView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
    

    // activate를 통한 제약조건 활성화
    secondView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      secondView.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 40),
      secondView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor, constant: 40),
      secondView.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -40),
      secondView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor, constant: -40),
    ])
  }
}



// MARK: - NSLayoutConstraint, VisualFormat

extension ViewController {  //구버전식 사용방법. 불필요
  private func activateNSLayoutConstraintConstraints() {
    firstView.translatesAutoresizingMaskIntoConstraints  = false
    secondView.translatesAutoresizingMaskIntoConstraints  = false
    
    // FirstView <-> View
    NSLayoutConstraint(
      item: firstView,
      attribute: .top,
      relatedBy: .equal,
      toItem: view,
      attribute: .top,
      multiplier: 1,
      constant: 50
      ).isActive = true
    
    NSLayoutConstraint(item: firstView, attribute: .leading,
                       relatedBy: .equal,
                       toItem: view, attribute: .leading,
                       multiplier: 1, constant: 50).isActive = true
    
    NSLayoutConstraint(item: firstView, attribute: .bottom,
                       relatedBy: .equal,
                       toItem: view, attribute: .bottom,
                       multiplier: 1, constant: -50).isActive = true
    
    NSLayoutConstraint(item: firstView, attribute: .trailing,
                       relatedBy: .equal,
                       toItem: view, attribute: .trailing,
                       multiplier: 1, constant: -50).isActive = true
    
    // SecondView <-> FirstView
    NSLayoutConstraint(item: secondView, attribute: .top, relatedBy: .equal, toItem: firstView, attribute: .top, multiplier: 1, constant: 40).isActive = true
    NSLayoutConstraint(item: secondView, attribute: .leading, relatedBy: .equal, toItem: firstView, attribute: .leading, multiplier: 1, constant: 40).isActive = true
    NSLayoutConstraint(item: secondView, attribute: .bottom, relatedBy: .equal, toItem: firstView, attribute: .bottom, multiplier: 1, constant: -40).isActive = true
    NSLayoutConstraint(item: secondView, attribute: .trailing, relatedBy: .equal, toItem: firstView, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
  }
  
  
  
  private func activateVisualFormat() {  //지금은 별로 안중요. 나중에 잘하게 되면 쓸까할만한 것.
    /***************************************************
     Visual Format Syntax
     https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html
     ***************************************************/
    
    firstView.translatesAutoresizingMaskIntoConstraints = false
    secondView.translatesAutoresizingMaskIntoConstraints = false
    
    let views: [String: Any] = ["firstView": firstView, "secondView": secondView]
    let metrics: [String: Any] = ["margin": 50, "padding": 40]
    let visualFormats: [String] = [
      "H:|-margin-[firstView]-margin-|",
      "V:|-margin-[firstView]-margin-|",
      "H:|-padding-[secondView]-padding-|",
      "V:|-padding-[secondView]-padding-|",
    ]
    // Superview와 제약 조건 설정
    
    var allConstraints: [NSLayoutConstraint] = []
    for visualFormat in visualFormats {
      allConstraints += NSLayoutConstraint.constraints(
        withVisualFormat: visualFormat,
        metrics: metrics,
        views: views
      )
    }
    NSLayoutConstraint.activate(allConstraints)
  }

}
