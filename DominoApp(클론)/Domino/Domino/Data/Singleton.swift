//
//  Singleton.swift
//  Domino
//
//  Created by 신용철 on 2019/12/27.
//  Copyright © 2019 신용철. All rights reserved.
//
import Foundation

final class Singleton {
  static let shared = Singleton()
  private init() {}
  
  var wishListDict: [String: Int] = [:]
}
