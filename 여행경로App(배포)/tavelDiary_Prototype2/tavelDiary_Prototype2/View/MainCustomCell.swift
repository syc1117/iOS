//
//  MainCustomCell.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/03/04.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class MainCustomCell: UITableViewCell {

    let titleLabel = UILabel()
    let scheduleLabel = UILabel()
    let pathLabel = UILabel()
    let memoLabel = UILabel()
    
    let titleLabel2 = UILabel()
    let scheduleLabel2 = UILabel()
    let pathLabel2 = UILabel()
    let memoLabel2 = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        
        [titleLabel,scheduleLabel, pathLabel,memoLabel].forEach {
            addSubview($0)
            $0.textColor = .darkGray
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }

        [titleLabel2, scheduleLabel2, pathLabel2, memoLabel2].forEach {
            addSubview($0)
            $0.textColor = .black
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 10
            $0.font = UIFont.systemFont(ofSize: 15, weight: .light)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }
        
        titleLabel.layout.top(constant: 15).leading(constant: 10).width(constant: 45)
        titleLabel2.layout.top(constant: 15).leading(equalTo: titleLabel.trailingAnchor, constant: 10)
        scheduleLabel.layout.top(equalTo: titleLabel.bottomAnchor, constant: 15).leading(constant: 10).width(constant: 45)
        scheduleLabel2.layout.top(equalTo: titleLabel.bottomAnchor, constant: 15).leading(equalTo: scheduleLabel.trailingAnchor, constant: 10).trailing(constant: -10)
        
        pathLabel.layout.top(equalTo: scheduleLabel.bottomAnchor, constant: 15).leading(constant: 10).width(constant: 45)
        pathLabel2.layout.top(equalTo: pathLabel.topAnchor).leading(equalTo: pathLabel.trailingAnchor, constant: 10).trailing(constant: -10)

        memoLabel.layout.top(equalTo: pathLabel2.bottomAnchor, constant: 15).leading(constant: 10).width(constant: 45)
        memoLabel2.layout.top(equalTo: pathLabel2.bottomAnchor, constant: 15).leading(equalTo: memoLabel.trailingAnchor, constant: 10).trailing(constant: -10).bottom(constant: -10)
//
//        layer.borderWidth = 0.5
//        layer.borderColor = UIColor.gray.cgColor
//        layer.cornerRadius = 10
//        clipsToBounds = true
        
        titleLabel.text = "제 목:"
        scheduleLabel.text = "일 정:"
        pathLabel.text = "경 로:"
        memoLabel.text = "메 모:"
    }
}
