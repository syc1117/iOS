//
//  FirstTableViewCell.swift
//  WeatherForecast
//
//  Created by 신용철 on 2020/03/06.
//  Copyright © 2020 신용철 All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    let imgView = UIImageView()
    let status = UILabel()
    let subStatus = UILabel()
    let temperature = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        addSubviews([imgView, status, subStatus, temperature])
        imgView.layout.top().leading(constant: 10)
        imgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        status.layout.top(equalTo: imgView.topAnchor).trailing(constant: -15).leading(equalTo: imgView.trailingAnchor, constant: 10)
        status.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        subStatus.layout.leading(equalTo: imgView.leadingAnchor).trailing(equalTo: status.trailingAnchor).top(equalTo: status.bottomAnchor, constant: 10)
        subStatus.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        
        temperature.layout.leading(equalTo: subStatus.leadingAnchor).trailing().top(equalTo: subStatus.bottomAnchor, constant: 10).bottom()
        
        temperature.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        
        
        status.text = "맑음"
        status.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        status.textColor = .white
        
        subStatus.text = "구름없음"
        subStatus.font = UIFont.systemFont(ofSize: 20, weight: .light)
        subStatus.textColor = .white
        
        temperature.text = "25℃"
        temperature.font = UIFont.systemFont(ofSize: 100, weight: .ultraLight)
        temperature.textColor = .white
        
        imgView.image = UIImage(named: "SKY_S01")
    }
}
