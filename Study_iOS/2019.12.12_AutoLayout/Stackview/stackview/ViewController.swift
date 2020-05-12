//
//  ViewController.swift
//  stackview
//
//  Created by 신용철 on 2019/12/20.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var total = 0
    var totalLabel = UILabel()
    let nameLabel = UILabel()
    
    
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    
    let button5 = UIButton()
    let button6 = UIButton()
    let button7 = UIButton()
    let button8 = UIButton()
    
    let button9 = UIButton()
    let button10 = UIButton()
    let button11 = UIButton()
    let button12 = UIButton()
    
    let button13 = UIButton()
    let button14 = UIButton()
    let button15 = UIButton()
    let button16 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        buttonSet()
  
    }
    
    override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
        view.addSubview(nameLabel)
        nameLabel.text = "기민과 용철의 첫번째 계산기"
        nameLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        
        //totalLabel-autoLayout
        let safezone = view.safeAreaInsets.top
        print("\(safezone)")
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: safezone + 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    @objc func didtouch1(_ sender: UIButton){
    }
    
    
    func buttonAction(){
        button1.addTarget(self, action: #selector(didtouch1), for: .touchUpInside)
        
    }
    
    
    func buttonSet(){
        
        
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView2 = UIStackView()
        view.addSubview(stackView2)
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView3 = UIStackView()
        view.addSubview(stackView3)
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView4 = UIStackView()
        view.addSubview(stackView4)
        stackView4.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView5 = UIStackView()
        view.addSubview(stackView5)
        stackView5.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(totalLabel)
        totalLabel.text = "\(total)"
        totalLabel.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        totalLabel.textAlignment = .right
        totalLabel.textColor = .white
        
        
        
        
        //totalLabel-autoLayout
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        totalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        totalLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -15).isActive = true
        
        button1.setTitle("1", for: .normal)
        button2.setTitle("2", for: .normal)
        button3.setTitle("3", for: .normal)
        button4.setTitle("+", for: .normal)
        
        button5.setTitle("4", for: .normal)
        button6.setTitle("5", for: .normal)
        button7.setTitle("6", for: .normal)
        button8.setTitle("-", for: .normal)
        
        button9.setTitle("7", for: .normal)
        button10.setTitle("8", for: .normal)
        button11.setTitle("9", for: .normal)
        button12.setTitle("x", for: .normal)
        
        button13.setTitle("0", for: .normal)
        button14.setTitle("AC", for: .normal)
        button15.setTitle("=", for: .normal)
        button16.setTitle("/", for: .normal)
        
        button1.setTitleColor(.white, for: .highlighted)
        button2.setTitleColor(.white, for: .highlighted)
        button3.setTitleColor(.white, for: .highlighted)
        button4.setTitleColor(.white, for: .highlighted)
        
        button5.setTitleColor(.white, for: .highlighted)
        button6.setTitleColor(.white, for: .highlighted)
        button7.setTitleColor(.white, for: .highlighted)
        button8.setTitleColor(.white, for: .highlighted)
        
        button9.setTitleColor(.white, for: .highlighted)
        button10.setTitleColor(.white, for: .highlighted)
        button11.setTitleColor(.white, for: .highlighted)
        button12.setTitleColor(.white, for: .highlighted)
        
        button13.setTitleColor(.white, for: .highlighted)
        button14.setTitleColor(.white, for: .highlighted)
        button15.setTitleColor(.white, for: .highlighted)
        button16.setTitleColor(.white, for: .highlighted)
        
        button1.titleLabel?.font = UIFont(name: "2", size: 20)
        
        button1.backgroundColor = .darkGray
        button2.backgroundColor = .darkGray
        button3.backgroundColor = .darkGray
        button4.backgroundColor = .orange
        
        button5.backgroundColor = .darkGray
        button6.backgroundColor = .darkGray
        button7.backgroundColor = .darkGray
        button8.backgroundColor = .orange
        
        button9.backgroundColor = .darkGray
        button10.backgroundColor = .darkGray
        button11.backgroundColor = .darkGray
        button12.backgroundColor = .orange
        
        button13.backgroundColor = .darkGray
        button14.backgroundColor = .darkGray
        button15.backgroundColor = .darkGray
        button16.backgroundColor = .orange
        
        button1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button3.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button4.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        
        button5.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button6.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button7.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button8.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        
        button9.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button10.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button11.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button12.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        
        button13.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button14.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button15.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button16.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        
        
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        stackView.addArrangedSubview(button4)
        
        stackView2.addArrangedSubview(button5)
        stackView2.addArrangedSubview(button6)
        stackView2.addArrangedSubview(button7)
        stackView2.addArrangedSubview(button8)
        
        stackView3.addArrangedSubview(button9)
        stackView3.addArrangedSubview(button10)
        stackView3.addArrangedSubview(button11)
        stackView3.addArrangedSubview(button12)
        
        stackView4.addArrangedSubview(button13)
        stackView4.addArrangedSubview(button14)
        stackView4.addArrangedSubview(button15)
        stackView4.addArrangedSubview(button16)
        
        stackView5.addArrangedSubview(stackView)
        stackView5.addArrangedSubview(stackView2)
        stackView5.addArrangedSubview(stackView3)
        stackView5.addArrangedSubview(stackView4)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        stackView4.translatesAutoresizingMaskIntoConstraints = false
        stackView5.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually//객체 간 간격, 크기 조정
        stackView.alignment = .fill // 정렬방식(위, 중간, 아래 맞춤)
        stackView.spacing = 8
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        stackView2.axis = .horizontal
        stackView2.distribution = .fillEqually//객체 간 간격, 크기 조정
        stackView2.alignment = .fill // 정렬방식(위, 중간, 아래 맞춤)
        stackView2.spacing = 8
//        stackView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        stackView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        //        stackView2.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 8).isActive = true
        
        stackView3.axis = .horizontal
        stackView3.distribution = .fillEqually//객체 간 간격, 크기 조정
        stackView3.alignment = .fill // 정렬방식(위, 중간, 아래 맞춤)
        stackView3.spacing = 8
        stackView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        //        stackView3.topAnchor.constraint(equalTo: stackView2.topAnchor, constant: 8).isActive = true
        
        stackView4.axis = .horizontal
        stackView4.distribution = .fillEqually//객체 간 간격, 크기 조정
        stackView4.alignment = .fill // 정렬방식(위, 중간, 아래 맞춤)
        stackView4.spacing = 8
        stackView4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        //        stackView4.topAnchor.constraint(equalTo: stackView3.topAnchor, constant: 8).isActive = true
        //
        stackView5.axis = .vertical
        stackView5.distribution = .equalSpacing//객체 간 간격, 크기 조정
        stackView5.alignment = .center // 정렬방식(위, 중간, 아래 맞춤)
        stackView5.spacing = 8
        //        stackView5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        //        stackView5.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        stackView5.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        stackView5.axis = .vertical //정렬방향(가로, 세로)
        stackView5.distribution = .fillEqually//객체 간 간격, 크기 조정
        stackView5.alignment = .fill // 정렬방식(위, 중간, 아래 맞춤)
        stackView5.spacing = 8
        stackView5.topAnchor.constraint(equalTo:view.topAnchor, constant: 400).isActive = true
    stackView5.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -100).isActive = true
        
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
        //        let margin: CGFloat = 20
        //        let pedding: CGFloat  = 8
        //        let safeLayoutInsects = view.safeAreaInsets
        //        let horizontalInsect = safeLayoutInsects.left + safeLayoutInsects.right
        //
        //        let yOffset = safeLayoutInsects.bottom + margin
        //        let buttonWidth = (view.frame.width - horizontalInsect - pedding - margin * 2) / 4
        //        let buttonHeight: CGFloat = buttonWidth
        //
        
        
    }
    
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        let stackView = UIStackView()
    //        stackView.axis = .vertical //정렬방향(가로, 세로)
    //        stackView.distribution = .fillEqually//객체 간 간격, 크기 조정
    //        stackView.alignment = .center // 정렬방식(위, 중간, 아래 맞춤)
    //        stackView.spacing = 8
    //        view.addSubview(stackView)
    //        stackView.translatesAutoresizingMaskIntoConstraints = false
    //        stackView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
    //        stackView.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
    //        let someLabel = UILabel()
    //        someLabel.text = "someLabel"
    //        stackView.addArrangedSubview(someLabel)
    //        let someLabel2 = UILabel()
    //        someLabel2.text = "someLabeㄴㄴㄴㄴㄴl"
    //        stackView.addArrangedSubview(someLabel2)
    //        let someLabel3 = UILabel()
    //        someLabel3.text = "someLabel"
    //        stackView.addArrangedSubview(someLabel3)
    //        let someLabel4 = UILabel()
    //        someLabel4.text = "someLabel"
    //        stackView.addArrangedSubview(someLabel4)
    //    }
    //
    
//}

