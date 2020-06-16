//
//  textViewCell.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/03/12.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class textViewCell: UITableViewCell {
    
    let textView = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(textView)
        textView.backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
        textView.layout.top().leading().trailing().bottom()
        textView.font = UIFont.systemFont(ofSize: 18)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
