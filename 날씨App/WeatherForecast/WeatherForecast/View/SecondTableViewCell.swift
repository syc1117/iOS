//
//  SecondTableViewCell.swift
//  WeatherForecast
//
//  Created by 신용철 on 2020/03/06.
//  Copyright © 2020 신용철 All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    
    let temperature = UILabel()
    let status = UILabel()
    let subStatus = UILabel()
    let totalStatus = UILabel()
    let imgView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView(){
        addSubviews([temperature, status, subStatus, totalStatus ,imgView])
        temperature.layout.top(constant: 10).bottom(constant: -10).trailing()
        temperature.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        temperature.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        temperature.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        temperature.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        
        status.layout.trailing(equalTo: temperature.leadingAnchor, constant: -10).centerY(equalTo: temperature.centerYAnchor)
        
        subStatus.layout.top(constant: 22).leading(constant: 10)
        
        subStatus.trailingAnchor.constraint(lessThanOrEqualTo: imgView.leadingAnchor, constant: -10).isActive = true
        
        totalStatus.layout.top(equalTo: subStatus.bottomAnchor, constant: 2).leading(equalTo: subStatus.leadingAnchor)
        totalStatus.trailingAnchor.constraint(lessThanOrEqualTo: imgView.leadingAnchor, constant: -10).isActive = true

        imgView.layout.trailing(equalTo: status.leadingAnchor, constant: -10).centerY(equalTo: status.centerYAnchor)
        
        imgView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        temperature.text = "00"
        temperature.font = UIFont.systemFont(ofSize: 30, weight: .thin)
        temperature.textColor = .white
        
        status.text = "label2"
        status.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        status.textColor = .white
        
        subStatus.text = "label3"
        subStatus.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        subStatus.textColor = .white
        
        totalStatus.text = "label4"
        totalStatus.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        totalStatus.textColor = .lightGray
        
        imgView.image = UIImage(named: "SKY_S01")
        
    }
}
