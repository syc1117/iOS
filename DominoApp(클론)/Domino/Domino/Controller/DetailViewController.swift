//
//  DetailViewController.swift
//  Domino
//
//  Created by 신용철 on 2019/12/27.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var shared = Singleton.shared
  var productName = ""
  var selectCount: Int = 0 {
    didSet {
      displayLabel.text = "\(selectCount) 개"
    }
  }
  
  let imageView = UIImageView()
  private let tempView = UIView()
  private let minusButton = UIButton()
  private let displayLabel = UILabel()
  private let plusButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    configure()
    autoLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    if let value = shared.wishListDict[productName] {
      selectCount = value
      
    } else {
      selectCount = 0
    }
  }
  
  private func configure() {
    imageView.contentMode = .scaleToFill
    imageView.backgroundColor = .black
    view.addSubview(imageView)
    
    view.addSubview(tempView)
    
    minusButton.setTitle("-", for: .normal)
    minusButton.setTitleColor(.black, for: .normal)
    minusButton.layer.borderWidth = 3
    minusButton.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    minusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    tempView.addSubview(minusButton)
    
    displayLabel.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    displayLabel.text = "\(selectCount) 개"
    displayLabel.textAlignment = .center
    displayLabel.textColor = .white
    tempView.addSubview(displayLabel)
    
    plusButton.setTitle("+", for: .normal)
    plusButton.setTitleColor(.black, for: .normal)
    plusButton.layer.borderWidth = 3
    plusButton.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    plusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    tempView.addSubview(plusButton)
  }
  
  private struct Standard {
    static let space: CGFloat = 48
  }
  
  private func autoLayout() {
    let guide = view.safeAreaLayoutGuide
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.topAnchor.constraint(equalTo: guide.topAnchor, constant: Standard.space).isActive = true
    imageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    imageView.widthAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
    
    tempView.translatesAutoresizingMaskIntoConstraints = false
    tempView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: Standard.space).isActive = true
    tempView.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -Standard.space).isActive = true
    tempView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -Standard.space).isActive = true
    tempView.heightAnchor.constraint(equalToConstant: Standard.space).isActive = true
    
    minusButton.translatesAutoresizingMaskIntoConstraints = false
    minusButton.topAnchor.constraint(equalTo: tempView.topAnchor).isActive = true
    minusButton.leadingAnchor.constraint(equalTo: tempView.leadingAnchor).isActive = true
    minusButton.bottomAnchor.constraint(equalTo: tempView.bottomAnchor).isActive = true
    minusButton.widthAnchor.constraint(equalTo: tempView.widthAnchor, multiplier: 0.2).isActive = true
    
    displayLabel.translatesAutoresizingMaskIntoConstraints = false
    displayLabel.topAnchor.constraint(equalTo: tempView.topAnchor).isActive = true
    displayLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor).isActive = true
    displayLabel.bottomAnchor.constraint(equalTo: tempView.bottomAnchor).isActive = true
    displayLabel.widthAnchor.constraint(equalTo: tempView.widthAnchor, multiplier: 0.6).isActive = true
    
    plusButton.translatesAutoresizingMaskIntoConstraints = false
    plusButton.topAnchor.constraint(equalTo: tempView.topAnchor).isActive = true
    plusButton.leadingAnchor.constraint(equalTo: displayLabel.trailingAnchor).isActive = true
    plusButton.trailingAnchor.constraint(equalTo: tempView.trailingAnchor).isActive = true
    plusButton.bottomAnchor.constraint(equalTo: tempView.bottomAnchor).isActive = true
    plusButton.widthAnchor.constraint(equalTo: tempView.widthAnchor, multiplier: 0.2).isActive = true
  }
  
  @objc private func buttonAction(_ sender: UIButton) {
    switch sender {
    case minusButton:
      guard selectCount > 0 else {return}
      selectCount -= 1
      
    case plusButton:
      selectCount += 1
      
    default:
      break
    }
    
    guard selectCount != 0 else {shared.wishListDict[productName] = nil; return}
    shared.wishListDict[productName] = selectCount
  }
}

