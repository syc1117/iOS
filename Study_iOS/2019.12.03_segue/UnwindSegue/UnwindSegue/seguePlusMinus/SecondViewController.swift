//
//  SecondViewController.swift
//  seguePlusMinus
//
//  Created by 신용철 on 2019/12/21.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var secondTotal = 0
    var minus = 0
    let secondLabel = UILabel()
    let textField = UITextField()
    
    @IBOutlet weak var dismiss: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(secondLabel)
        view.addSubview(textField)
        
        setupUI()
    }
    
    func setupUI(){
        
        secondLabel.text = "\(secondTotal)"
        secondLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        
        textField.font = UIFont.systemFont(ofSize: 30) //
        textField.borderStyle = .roundedRect //모서리가 둥근 사각형
        textField.adjustsFontSizeToFitWidth = true //글자수 초과하면 글자수 작아짐(미니멈으로 설정한 데 까지)
        textField.clearsOnBeginEditing = true //편집시작하면 기존에 작성된 것 초기화
        textField.placeholder = "빼고싶은 값을 입력하시오"
        textField.addTarget(self, action: #selector(didTouch), for: .editingDidEndOnExit)
        
        dismiss.setTitle("뒤로가기", for: .normal)
        dismiss.setTitleColor(.blue, for: .normal)
        dismiss.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        
    }
    
    @objc func didTouch(){
        guard let minusInput = Int(textField.text ?? "0") else { return }
        self.minus = minusInput
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150 + view.safeAreaInsets.top).isActive = true
        secondLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 250 + view.safeAreaInsets.top).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60).isActive = true
        
        dismiss.translatesAutoresizingMaskIntoConstraints = false
        dismiss.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        dismiss.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    
}

