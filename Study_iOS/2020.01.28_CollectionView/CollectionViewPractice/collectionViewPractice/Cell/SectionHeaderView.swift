//
//  SectionHeaderView.swift
//  collectionViewStarter
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
//viewForSupplementaryElementOfKind 함수에서 반환 타입이 UICollectionReusableView
class SectionHeaderView: UICollectionReusableView {
     let blurView = UIVisualEffectView()
    private let imageView = UIImageView()
    private let label = UILabel()
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupLayout()
    }
    
    func setup(){
        let blurEffet = UIBlurEffect(style: .dark)
        blurView.effect = blurEffet
        addSubview(blurView)
        
        label.textColor = .white
        imageView.contentMode = .scaleToFill
        blurView.contentView.addSubview(imageView)
        blurView.contentView.addSubview(label)
    }
    
    func setupLayout(){
        [blurView, imageView, label].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: blurView.contentView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: blurView.contentView.leadingAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalTo:blurView.contentView.heightAnchor, multiplier: 0.8),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.5),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    func configure(text: String){
        imageView.image = UIImage(named: text)
        label.text = text
    }
    
}
