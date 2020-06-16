//
//  WeekDaysView.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/03/09.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class WeekdaysView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews(){
        addSubview(stackView)
        stackView.layout.top().leading().trailing().bottom()
        
        let daysArr = ["일","월","화","수","목","금","토"]
        for i in 0..<7 {
            let lbl = UILabel()
            lbl.text = daysArr[i]
            lbl.textAlignment = .center
            lbl.textColor = .black
            stackView.addArrangedSubview(lbl)
        }
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    
}

