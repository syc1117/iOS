//
//  ViewController.swift
//  ShoppingItems
//
//  Created by giftbot on 2019. 12. 17..
//  Copyright © 2019년 giftbot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  private let itemManager = ItemManager()
  private lazy var items: [ShoppingItem] = itemManager.items
  private var orderItems: [String: Int] = [:]
}


// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.identifier, for: indexPath) as! ItemCell
    cell.delegate = self
    cell.setupCell(title: items[indexPath.row].title,
                   imageName: items[indexPath.row].imageName)
    cell.orderAmount = orderItems[cell.title] ?? 0
    return cell
  }
}


// MARK: - ItemCellDelegate

extension ViewController: ItemCellDelegate {
  func itemCell(_ itemCell: ItemCell, didTapAddButton: UIButton) {
    let isAvailable = itemManager.checkOrderAvailability(
      title: itemCell.title,
      orderAmount: itemCell.orderAmount + 1
    )
    guard isAvailable else {
      itemCell.backgroundColor = UIColor.red.withAlphaComponent(0.7)
      UIView.animate(withDuration: 0.8, animations: {
        itemCell.backgroundColor = .white
      })
      return print("재고가 부족합니다.")
    }
    
    itemCell.orderAmount += 1
    orderItems[itemCell.title] = itemCell.orderAmount
  }
}
