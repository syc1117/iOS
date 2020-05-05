//
//  CustumCell.swift
//  collectionViewStarter
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
   private let imageView = UIImageView()
   private let textLabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupAutoLayout()
    }
    
    func setupView(){
        addSubview(imageView)
        addSubview(textLabel)
        
        imageView.contentMode = .scaleToFill
        clipsToBounds = true
        
        textLabel.textColor = .black
        textLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        textLabel.textAlignment = .center
        textLabel.backgroundColor = .orange
    }
    
    func setupAutoLayout(){
        [imageView, textLabel].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        textLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
    
    func configure(img: UIImage?, text: String){
        imageView.image = img
        textLabel.text = text
    }
}
