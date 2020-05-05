//
//  ViewController.swift
//  DisplayTouchPoint
//
//  Created by giftbot on 2020/01/04.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit


final class ViewController: UIViewController {

  @IBOutlet private weak var tapCountLabel: UILabel!
  @IBOutlet private weak var tapPointLabel: UILabel!

  /***************************************************
   1) touchesBegan 메서드 이용
   ***************************************************/

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard let touch = touches.first else { return }
    tapCountLabel.text = "횟수 : \(touch.tapCount)"
    tapPointLabel.text = "좌표 : \(touch.location(in: touch.view))"
  }

  /***************************************************
   2) UITapGestureRecognizer 이용
   ***************************************************/

  var lastTapPoint = CGPoint.zero
  var tapCount = 0
  @IBAction func handleTapGesture(_ sender: UITapGestureRecognizer) {
    guard let tappedView = sender.view else { return }
    let tapPoint = sender.location(in: tappedView)
    tapPointLabel.text = "좌표 : \(tapPoint)"

    let xSquare = pow(lastTapPoint.x - tapPoint.x, 2)
    let ySquare = pow(lastTapPoint.y - tapPoint.y, 2)
    if sqrt(xSquare + ySquare) > 10 {
      tapCount = 0
    }
    tapCount += 1
    tapCountLabel.text = "횟수 : \(tapCount)"

    lastTapPoint = tapPoint
  }

}


// MARK: - UIGestureRecognizerDelegate

extension ViewController: UIGestureRecognizerDelegate {
  /***************************************************
   3) UIGestureRecognizerDelegate 이용
   ***************************************************/
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    tapCountLabel.text = "횟수 : \(touch.tapCount)"
    tapPointLabel.text = "좌표 : \(touch.location(in: touch.view))"
    return false
  }
}
