//
//  SearchCell.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/04.
//  Copyright © 2020 신용철. All rights reserved.
//
import UIKit

extension Notification.Name {
    static let likeNotification = Notification.Name("LikeNoti")
}

class SearchCell: UITableViewCell {
    
    private let imgView = UIImageView()
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    private let likeButton = UIButton()
    
    @objc func didTabLikeButton(_ sender: UIButton){
        let noti = Notification(name: .likeNotification)
        NotificationCenter.default.post(noti)
//        likeButton.setBackgroundImage(UIImage(named: "fullheart"), for: .normal)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        
        contentView.addSubviews([imgView,titleLabel,artistLabel, likeButton])
        
        contentMode = .scaleAspectFit
        contentView.clipsToBounds = true
        imgView.layer.cornerRadius = 20
        imgView.clipsToBounds = true
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        
        
        artistLabel.textColor = .darkGray
        artistLabel.font = UIFont.systemFont(ofSize: 12)
        artistLabel.textAlignment = .left
        
        likeButton.setBackgroundImage(UIImage(named: "emptyheart"), for: .normal)
        
        likeButton.addTarget(self, action: #selector(didTabLikeButton), for: .touchUpInside)
        
        
        
        
        imgView.layout.leading(constant: 1).top(constant: 1).bottom(constant: 1)
        imgView.widthAnchor.constraint(equalTo: imgView.heightAnchor).isActive = true
        
        
        titleLabel.layout.trailing(equalTo: likeButton.leadingAnchor, constant: -10).leading(equalTo: imgView.trailingAnchor, constant: 10).centerY(equalTo: contentView.centerYAnchor, constant: -10)
        //        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        artistLabel.layout.top(equalTo: titleLabel.bottomAnchor, constant: 5).trailing().leading(equalTo: imgView.trailingAnchor, constant: 10)
        //        artistLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.layout.centerY().trailing(constant: -15)
        likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(img1: UIImage?,
                   title: String, name: String ){
        
        imgView.image = img1
        titleLabel.text = title
        artistLabel.text = name
    }
}



