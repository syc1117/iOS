//
//  MyPlayListCell.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/03.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class MyPlayListCell: UICollectionViewCell {
    // 이미지뷰 4개, 레이블 2개
    
   private let imgView1 = UIImageView()
   private let imgView2 = UIImageView()
   private let imgView3 = UIImageView()
   private let imgView4 = UIImageView()
    
   private let titleLabel = UILabel()
   private let numberLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        addSubviews([imgView1,imgView2,imgView3,imgView4,titleLabel,numberLabel])
        imgView1.contentMode = .scaleToFill
        imgView2.contentMode = .scaleToFill
        imgView3.contentMode = .scaleToFill
        imgView4.contentMode = .scaleToFill
        contentView.clipsToBounds = true
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        
        
        numberLabel.textColor = .darkGray
        numberLabel.font = UIFont.systemFont(ofSize: 15)
        numberLabel.textAlignment = .left

    }
    
    func layout(){
        numberLabel.layout.bottom().trailing().leading()
        numberLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        titleLabel.layout.bottom(equalTo: numberLabel.topAnchor, constant: 5).trailing().leading()
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        let width = (contentView.frame.width / 2).rounded(.down)
        let height = ((contentView.frame.height - titleLabel.frame.height - numberLabel.frame.height - 5) / 2).rounded(.down)
        
        [imgView1,imgView2,imgView3,imgView4].forEach{
            $0.widthAnchor.constraint(equalToConstant: width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        imgView1.layout.leading().top()
        imgView2.layout.trailing().top()
        imgView3.layout.leading().bottom()
        imgView4.layout.trailing().bottom()
        
    }
    
    func configure(img1: UIImage?, img2: UIImage?,
                   img3: UIImage?, img4: UIImage?,
                   title: String, number: String ){
        
        imgView1.image = img1
        imgView2.image = img2
        imgView3.image = img3
        imgView4.image = img4

        titleLabel.text = title
        numberLabel.text = number
    }
}
