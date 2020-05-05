//
//  TextStorage.swift
//  TextDataTransfer
//
//  Created by Giftbot on 2019/11/30
//  Copyright © 2019 giftbot. All rights reserved.
//

import Foundation

class TextStorage {
  static let shared = TextStorage()
  private init() {}
  var text: String?
}
