//
//  ViewController.swift
//  FoldingMenusExample
//
//  Created by giftbot on 2020/01/07..
//  Copyright © 2020년 giftbot. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  private struct Time {
    static let short = 0.3
    static let middle = 0.65
    static let long = 1.0
  }
  
  private struct UI {
    static let menuCount = 5
    static let menuSize: CGFloat = 60
    static let distance: CGFloat = 130
    static let minScale: CGFloat = 0.3
  }
  
  private var firstMenuContainer: [UIButton] = []
  private var secondMenuContainer: [UIButton] = []
  
  
  // MARK: - LifeCycle
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFirstMenu()
    setupSecondMenu()
  }
  
  // MARK: - Setup UI
  
  private func randomColorGenerator() -> UIColor {
    let red = CGFloat.random(in: 0...1.0)
    let green = CGFloat.random(in: 0...1.0)
    let blue = CGFloat.random(in: 0...1.0)
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
  }
  
  private func makeMenuButton(with frame: CGRect, title: String) -> UIButton {
    let button = UIButton(frame: frame)
    button.backgroundColor = randomColorGenerator()
    button.setTitle(title, for: .normal)
    button.layer.cornerRadius = button.bounds.width / 2
    button.transform = button.transform.scaledBy(x: UI.minScale, y: UI.minScale)
    view.addSubview(button)
    return button
  }
  
  private func setupFirstMenu() {
    for i in (0..<UI.menuCount) {
      let menuFrame = CGRect(
        x: 50, y: view.bounds.height - 120,
        width: UI.menuSize, height: UI.menuSize
      )
      let button = makeMenuButton(with: menuFrame, title: "버튼 \(i)")
      firstMenuContainer.append(button)
      
        //첫번째 버튼에만 클릭 기능 제공
      if i == 0 {
        button.transform = .identity//transform: 중심좌표를 기준으로 늘리거나 줄이거나 회전하는 기능제공
        button.addTarget(self, action: #selector(firstMenuDidTap(_:)), for: .touchUpInside)
      }
    }
    //첫번째 버튼(0번)을 뷰의 맨 앞으로 가지고 오라(버튼 5개가 겹쳐있기때문에)
    view.bringSubviewToFront(firstMenuContainer.first!) //특정뷰를 화면 맨 앞으로 가지고 오는 명령어
  }
  
  
  private func setupSecondMenu() {
    for i in (0..<UI.menuCount) {
      let menuFrame = CGRect(
        x: view.bounds.width - 50 - UI.menuSize, y: view.bounds.height - 120,
        width: UI.menuSize, height: UI.menuSize
      )
      let button = makeMenuButton(with: menuFrame, title: "버튼\(i)")
      secondMenuContainer.append(button)
      
      if i == 0 {
        button.transform = .identity
        button.addTarget(self, action: #selector(secondMenuDidTap(_:)), for: .touchUpInside)
      }
    }
    view.bringSubviewToFront(secondMenuContainer.first!)
  }
  
  
  
  // MARK: - ActionHandler
  
  @objc private func firstMenuDidTap(_ button: UIButton) {
    button.isSelected.toggle()
    
    UIView.animate(
      withDuration: Time.middle,
      delay: 0,
      usingSpringWithDamping: 0.8,
      initialSpringVelocity: 0.0,
      animations: {
        for (idx, menu) in self.firstMenuContainer.enumerated() {
          guard idx != 0 else { continue }//첫번째 버튼은 움직이지 말아야하므로
          if button.isSelected {
            menu.transform = .identity
            menu.center.y -= UI.distance * CGFloat(idx)
          } else {
            menu.transform = menu.transform.scaledBy(x: UI.minScale, y: UI.minScale)
            menu.center.y += UI.distance * CGFloat(idx)
          }
        }
    })
  }
  
  
  @objc private func secondMenuDidTap(_ button: UIButton) {
    button.isSelected.toggle()
    var startTime = 0.0
    var duration = 1.0 / Double(UI.menuCount)
    
    UIView.animateKeyframes(
      withDuration: Time.middle,
      delay: 0,
      options: [.beginFromCurrentState],
      animations: {
        for i in 1..<UI.menuCount {
          defer { startTime += duration }
          UIView.addKeyframe(
            withRelativeStartTime: startTime,
            relativeDuration: duration,
            animations: {
              self.keyFrameAnimation(index: i, selected: button.isSelected)
          })
        }
    })
  }
  
  private func keyFrameAnimation(index: Int, selected: Bool) {
    if selected {    // 메뉴 열기
      secondMenuContainer[index].transform = .identity
      secondMenuContainer.enumerated()
        .filter { $0.offset >= index }
        .forEach { $0.element.center.y -= UI.distance }
    } else {    // 메뉴 닫기
      let scaleTransform = CGAffineTransform(scaleX: UI.minScale, y: UI.minScale)
      secondMenuContainer[UI.menuCount - index].transform = scaleTransform
      secondMenuContainer.enumerated()
        .filter { $0.offset >= UI.menuCount - index }
        .forEach { $0.element.center.y += UI.distance }
    }
  }
}





