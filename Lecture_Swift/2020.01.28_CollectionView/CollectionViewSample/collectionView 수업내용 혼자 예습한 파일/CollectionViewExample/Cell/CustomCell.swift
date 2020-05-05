//
//  CustomCell.swift
//  CollectionViewExample
//
//  Created by giftbot on 2020/01/24.
//  Copyright © 2020 giftbot. All rights reserved.
//

import UIKit

final class CustomCell: UICollectionViewCell {
    static let identifier = "CustomCell"
    private let imgView = UIImageView()
    private let titleLabel = UILabel()
    // MARK: Init
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    // MARK: Setup
    
    private func setupViews() {
        addSubview(imgView)
        addSubview(titleLabel)
        
        imgView.contentMode = .scaleAspectFill
        clipsToBounds = true
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    private func setupConstraints() {
        [imgView, titleLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    // MARK: Configure Cell
    func configure(_ title: String){
        imgView.image = UIImage(named: title)
        titleLabel.text = title
    }
}
