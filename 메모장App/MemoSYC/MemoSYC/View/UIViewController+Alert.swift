//
//  UIViewController+Alert.swift
//  MemoSYC
//
//  Created by 신용철 on 2020/06/15.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
