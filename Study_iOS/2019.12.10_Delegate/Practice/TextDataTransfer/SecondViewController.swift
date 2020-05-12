//
//  SecondViewController.swift
//  TextDataTransfer
//
//  Created by 이봉원 on 2019/11/30.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

protocol SecondToFirstDelegate: class {
  func sendText() -> String
}

final class SecondViewController: UIViewController {
  
  @IBOutlet private weak var displayLabel: UILabel!
  weak var delegate: SecondToFirstDelegate?
  var text: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let text = self.text ?? delegate?.sendText()
    displayLabel.text = text
  }
}


// MARK: - FirstToSecondDelegate

extension SecondViewController: FirstToSecondDelegate {
  func sendText(_ text: String) {
    self.text = text
  }
}
