//
//  SecondViewController.swift
//  TextDataTransfer
//
//  Created by Giftbot on 2019/11/30
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class SecondViewController: UIViewController {
  
  @IBOutlet private weak var displayLabel: UILabel!
  var text: String?
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let text = TextStorage.shared.text   // Singleton
      ?? UserDefaults.standard.string(forKey: "UD")  // UserDefaults
    
    displayLabel.text = text
  }
}
