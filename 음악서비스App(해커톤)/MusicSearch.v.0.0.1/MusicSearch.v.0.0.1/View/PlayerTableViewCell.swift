//
//  SearchCell.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/04.
//  Copyright © 2020 신용철. All rights reserved.
//
import UIKit
extension Notification.Name {
    static let isPlaying = Notification.Name(rawValue: "isPlaying")
    static let play = Notification.Name(rawValue: "play")
}

class PlayerTableViewCell: UITableViewCell {
    
    private let imgView = UIImageView()
    private let titleLabel = UILabel()
    private let artistLabel = UILabel()
    private let playButton = UIButton()
    var trufalse = true
    
    @objc func didTabPlayButton(_ sender: UIButton){
        
        //플레이가 되고 있는지 여부를 확인하는 방법으로 조건문 설정
        //플레이 정보 받아오는 방법? viewcontroller에서 신호 보내는 방법
        if trufalse {
        let noti = Notification(name: .stopMusic)
        NotificationCenter.default.post(noti)
        let noti1 = Notification(name: .stopMusic2)
        NotificationCenter.default.post(noti1)
        let noti2 = Notification(name: .stopMusic3)
        NotificationCenter.default.post(noti2)
        playButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
        } else {
            NotificationCenter.default.post(Notification(name: .play))
           playButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)
        }
        trufalse.toggle()
//        likeButton.setBackgroundImage(UIImage(named: "fullheart"), for: .normal)
    }
    
    @objc func isPlayingMusic(_ sender: Notification){
               guard let userInfo = sender.userInfo as? [String: Bool],
                     let trueFalse = userInfo["isPlaying"]  else { return }
              trufalse = trueFalse
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(isPlayingMusic), name: .isPlaying, object: nil)
        contentView.addSubviews([imgView,titleLabel,artistLabel, playButton])
        
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
        
        playButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)
        
        playButton.addTarget(self, action: #selector(didTabPlayButton), for: .touchUpInside)
        
        imgView.layout.leading(constant: 1).centerY()
        imgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.layout.trailing(equalTo: playButton.leadingAnchor, constant: -10).leading(equalTo: imgView.trailingAnchor, constant: 10).centerY(equalTo: contentView.centerYAnchor, constant: -10)
        //        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        artistLabel.layout.top(equalTo: titleLabel.bottomAnchor, constant: 5).trailing().leading(equalTo: imgView.trailingAnchor, constant: 10)
        //        artistLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        playButton.layout.centerY().trailing(constant: -50)
        playButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
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



