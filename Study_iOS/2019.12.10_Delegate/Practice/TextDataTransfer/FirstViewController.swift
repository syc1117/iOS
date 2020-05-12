//
//  ViewController.swift
//  TextDataTransfer
//
//  Created by 이봉원 on 2019/11/30.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit


protocol FirstToSecondDelegate: class {
  func sendText(_ text: String)
}

final class FirstViewController: UIViewController {

  @IBOutlet private weak var textField: UITextField!
  weak var delegate1: FirstToSecondDelegate?
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let svc = segue.destination as? SecondViewController,
      let text = textField.text,
      let identifier = segue.identifier
      else { return }
    
    switch identifier {
    case "DelegateA":
      delegate1 = svc
      delegate1?.sendText(text)
    case "DelegateB":
      svc.delegate = self
    default: break
    }
  }
  
  @IBAction func unwindToFirstViewController(_ unwindSegue: UIStoryboardSegue) {
    guard let source = unwindSegue.source as? SecondViewController else { return }
    source.delegate = nil
  }
}

// MARK: - SecondToFirstDelegate

extension FirstViewController: SecondToFirstDelegate {
  func sendText() -> String {
    return textField.text ?? ""
  }
}

