//
//  Calendar.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/02/24.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

// MARK: "월"을 바꾸는 작동은 viewController에서 하기 때문에 delegate 사용
protocol MonthViewDelegate: class {
    func didChangeMonth(monthIndex: Int, year: Int)
}

class MonthView: UIView {
    var monthsArr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    var currentMonthIndex = 0
    var currentYear: Int = 0
    var currentMonth: Int = 0
    var delegate: MonthViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        currentMonthIndex = Calendar.current.component(. month, from: Date()) - 1
        currentYear = Calendar.current.component(.year, from: Date())
        
        setupViews()
        
        btnLeft.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubviews([lblName,btnRight, btnLeft])
        lblName.layout.top().centerX()
        lblName.widthAnchor.constraint(equalToConstant: 150).isActive = true
        lblName.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        lblName.text = "\(currentYear)년 \(monthsArr[currentMonthIndex])월"
        
        btnRight.layout.top().trailing()
        btnRight.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnRight.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
        btnLeft.layout.top().leading()
        btnLeft.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnLeft.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    @objc func btnLeftRightAction(sender: UIButton) {
        if sender == btnRight {
            currentMonthIndex += 1
            if currentMonthIndex > 11 {
                currentMonthIndex = 0
                currentYear += 1
            }
        } else {
            currentMonthIndex -= 1
            if currentMonthIndex < 0 {
                currentMonthIndex = 11
                currentYear -= 1
            }
        }
        lblName.text = "\(currentYear)년 \(monthsArr[currentMonthIndex])월"
        self.currentMonth = monthsArr[currentMonthIndex]
        delegate?.didChangeMonth(monthIndex: currentMonthIndex, year: currentYear)
    }
    
    let lblName: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    let btnRight: UIButton = {
        let btn = UIButton()
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnLeftRightAction), for: .touchUpInside)
        return btn
    }()
    
    let btnLeft: UIButton = {
        let btn = UIButton()
        btn.setTitle("<", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnLeftRightAction), for: .touchUpInside)
        return btn
    }()
}

