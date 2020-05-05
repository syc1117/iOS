//
//  CatSelectionCell.swift
//  CollectionViewPractice
//
//  Created by Giftbot on 2020/01/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

final class CatSelectionCell: UICollectionViewCell {
  
  static let identifier = "CatSelectionCell"
  
  private let imageView = UIImageView()
  private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
  private let checkMark = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    clipsToBounds = true
    layer.cornerRadius = 10
    
    imageView.contentMode = .scaleAspectFill
    backgroundView = imageView
    let selectedView = UIView()
    selectedBackgroundView = selectedView
    
    blurView.alpha = 0.5
    checkMark.tintColor = .systemBackground
    [blurView, checkMark].forEach {
      selectedView.addSubview($0)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.frame = contentView.frame
    blurView.frame = contentView.frame
    checkMark.frame = CGRect(x: bounds.width - 46, y: bounds.height - 46, width: 40, height: 40)
    selectedBackgroundView?.frame = contentView.frame
  }
  
  // MARK: Configure Cell

  func configure(image: UIImage) {
    imageView.image = image
  }
}
