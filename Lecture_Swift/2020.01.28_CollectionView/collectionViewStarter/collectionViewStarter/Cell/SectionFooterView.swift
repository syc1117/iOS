//
//  SectionFooterView.swift
//  collectionViewStarter
//
//  Created by 신용철 on 2020/01/21.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
//viewForSupplementaryElementOfKind 함수에서 반환 타입이 UICollectionReusableView
class SectionFooterView: UICollectionReusableView {
     
    private let blurView = UIVisualEffectView()
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
        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect
        addSubview(blurView)
    
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.preferredFont(forTextStyle: .body)
        titleLabel.textAlignment = .right
        blurView.contentView.addSubview(titleLabel)
    }
    
    func setupConstraints(){
        [blurView, titleLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            titleLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -20)
        ])
    }
    
    func configure(title: String){
        titleLabel.text = title
    }
}
