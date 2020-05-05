//
//  ViewController.swift
//  TextDataTransfer
//
//  Created by Giftbot on 2019/11/30
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit


final class FirstViewController: UIViewController {

  @IBOutlet private weak var textField: UITextField!
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let _ = segue.destination as? SecondViewController,
      let text = textField.text,
      let identifier = segue.identifier
      else { return }
    
    switch identifier {
    case "Singleton":
      TextStorage.shared.text = text
    case "UserDefaults":
      UserDefaults.standard.set(text, forKey: "UD")
    default: break
    }
  }
  
  @IBAction func unwindToFirstViewController(_ unwindSegue: UIStoryboardSegue) {
    TextStorage.shared.text = nil
    UserDefaults.standard.removeObject(forKey: "UD")
  }
}
