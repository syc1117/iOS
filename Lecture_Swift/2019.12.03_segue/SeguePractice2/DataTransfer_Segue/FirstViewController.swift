//
//  ViewController.swift
//  DataTransfer_Segue
//
//  Created by Giftbot on 2019/12/01.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class FirstViewController: UIViewController {
  
  @IBOutlet private weak var countLabel: UILabel!
  
  var counter: [String: Int] = ["dog": 0, "cat": 0, "bird": 0] {
    didSet {
      countLabel.text = "(\(counter["dog"]!), \(counter["cat"]!), \(counter["bird"]!))"
    }
  }
  
  
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
    guard let title = (sender as? UIButton)?.currentTitle?.lowercased(),
      let count = counter[title]
      else { return false }
    
    let limit = (8, 10, 15)
    
    switch title {
    case "dog": return count <= limit.0
    case "cat": return count <= limit.1
    case "bird": return count <= limit.2
    default: return false
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    guard let dest = segue.destination as? SecondViewController,
      let title = (sender as? UIButton)?.currentTitle?.lowercased(),
      let count = counter[title]
      else { return }
    dest.imageName = title
    counter[title] = count + 1
  }
  
  
  
  @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) {
    guard let source = unwindSegue.source as? SecondViewController else { return }
    for key in counter.keys {
      counter[key] = counter[key]! + source.tapCount
    }
  }
}

