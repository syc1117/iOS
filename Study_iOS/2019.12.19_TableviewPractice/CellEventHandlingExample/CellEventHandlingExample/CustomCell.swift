
//
//  CustomCell.swift
//  CellEventHandlingExample
//
//  Created by giftbot on 2019/12/17.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

protocol CustomCellDelegate: class {
  func customCell(_ customCell: CustomCell, didTapButton button: UIButton)
}

final class CustomCell: UITableViewCell {
    
  weak var delegate: CustomCellDelegate?
  let button = UIButton(type: .system)
  
  // 코드 사용 시
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(button)
    button.setTitle("MyButton", for: .normal)
    button.backgroundColor = .yellow
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
  }
  
  @objc func didTapButton(_ sender: UIButton) {
    delegate?.customCell(self, didTapButton: sender)
  }
  
  // 스토리보드 사용 시
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // View Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    button.frame = CGRect(
      x: frame.width - 120, y: 10,
      width: 80, height: frame.height - 20
    )
  }
  
}
