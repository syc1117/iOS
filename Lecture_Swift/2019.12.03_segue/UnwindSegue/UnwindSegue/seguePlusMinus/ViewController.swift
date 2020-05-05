//
//  ViewController.swift
//  seguePlusMinus
//
//  Created by 신용철 on 2019/12/21.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var ten: UIButton!
    @IBOutlet weak var manual: UIButton!
    
    let totalLabel = UILabel()
    var total = 0
    var minusFromSecondVC = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func manual(_ sender: Any) {
        if total < 50 {
            performSegue(withIdentifier: "ten", sender: sender)
        } else {
            performSegue(withIdentifier: "one", sender: sender)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        totalLabel.text = "\(total)"
    }
    
    @IBAction func unwindToView(_ unwindSegue: UIStoryboardSegue) {
        guard let secondVC = unwindSegue.source as? SecondViewController else { return }
        total -= secondVC.minus
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondvc = segue.destination as? SecondViewController else { return }
        if segue.identifier == "one" {
            total += 1
            secondvc.secondTotal = self.total
        } else {
            total += 10
            secondvc.secondTotal = self.total
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        return total < 50
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150 + view.safeAreaInsets.top).isActive = true
        totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
    }
    

    
    
    
    
    func setupUI(){
        totalLabel.text = "\(total)"
        totalLabel.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        view.addSubview(totalLabel)
        
        one.setTitle("+1", for: .normal)
        one.setTitleColor(.red, for: .normal)
        one.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        
        ten.setTitle("+10", for: .normal)
        ten.setTitleColor(.blue, for: .normal)
        ten.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        
        manual.setTitle("manual", for: .normal)
        manual.setTitleColor(.darkGray, for: .normal)
        manual.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        
        let stackView = UIStackView()
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        stackView.addArrangedSubview(one)
        stackView.addArrangedSubview(ten)
        stackView.addArrangedSubview(manual)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
    }
    

        
    
}

