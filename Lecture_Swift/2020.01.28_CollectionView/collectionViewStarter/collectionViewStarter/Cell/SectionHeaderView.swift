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
     
    private let blurView = UIVisualEffectView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        //blurView를 형성해서 blurView위에 이미지와 레이블을 삽입하기
        let blurEffect = UIBlurEffect(style: .dark)
        blurView.effect = blurEffect
        addSubview(blurView)
        
        blurView.contentView.addSubview(imageView)
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        blurView.contentView.addSubview(titleLabel)
    }
    
    func setupConstraints(){
        [blurView, imageView, titleLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalTo: blurView.heightAnchor, multiplier: 0.75),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.5),
            
            titleLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor)
        ])
    }
    
    func configure(image: UIImage?, title: String){
        imageView.image = image
        titleLabel.text = title
    }
}
