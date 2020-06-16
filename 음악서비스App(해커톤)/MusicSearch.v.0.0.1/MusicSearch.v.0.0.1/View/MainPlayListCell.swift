//
//  MainViewCell.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/03.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class MainPlayCell: UICollectionViewCell {
    
    private let imgView = UIImageView()
    
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        contentView.addSubviews([imgView,titleLabel,artistLabel])
        
        contentMode = .scaleToFill
        contentView.clipsToBounds = true
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        
        
        artistLabel.textColor = .darkGray
        artistLabel.font = UIFont.systemFont(ofSize: 15)
        artistLabel.textAlignment = .left
        
        
    }
    
    
    
    func layout(){
        artistLabel.layout.bottom().trailing().leading()
        //        artistLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        artistLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        titleLabel.layout.bottom(equalTo: artistLabel.topAnchor, constant: 10).trailing().leading()
        //        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imgView.layout.leading(equalTo: contentView.leadingAnchor).top(equalTo: contentView.topAnchor).bottom(equalTo: titleLabel.topAnchor, constant: 5).trailing()
    }
    
    func configure(img1: UIImage?,
                   title: String, name: String ){
        
        imgView.image = img1
        titleLabel.text = title
        artistLabel.text = name
    }
    
}


