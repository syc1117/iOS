//
//  DateCell.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/03/09.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class dateCVCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = self.bounds.width / 2
        layer.masksToBounds = true
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(lbl)
        lbl.layout.top().leading().trailing().bottom()
    }
    
    let lbl: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
}
