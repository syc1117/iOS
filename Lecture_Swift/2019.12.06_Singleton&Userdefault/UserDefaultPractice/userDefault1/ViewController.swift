//
//  ViewController.swift
//  userDefault1
//
//  Created by 신용철 on 2019/12/06.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   struct Key {
      static let imagePicker = "ImagePickerSwitch"
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imagePicker: UISwitch!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
      super.viewDidLoad()
      let isOn = userDefaults.bool(forKey: Key.imagePicker)
      imagePicker.setOn(isOn, animated: false)
      configureData(isOn: isOn)
    }
    
    @IBAction private func switchChanged(_ sender: UISwitch) {
      print("\n---------- [ 저장 상태 확인 ] ----------\n")
      configureData(isOn: sender.isOn)
      userDefaults.set(sender.isOn, forKey: Key.imagePicker)
      print(userDefaults.bool(forKey: Key.imagePicker))
    }
    
    func configureData(isOn: Bool) {
      let animal = isOn ? "dog" : "cat"
      imageView.image = UIImage(named: animal)
      titleLabel.text = animal
    }
}
