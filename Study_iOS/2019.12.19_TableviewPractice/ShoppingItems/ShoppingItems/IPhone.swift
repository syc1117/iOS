//
//  ShoppingItems.swift
//  ShoppingItems
//
//  Created by giftbot on 2019. 12. 17..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import Foundation

protocol ShoppingItem {
  var title: String { get }
  var imageName: String { get }
}

struct IPhone: ShoppingItem {
  let title: String
  let imageName: String
}
