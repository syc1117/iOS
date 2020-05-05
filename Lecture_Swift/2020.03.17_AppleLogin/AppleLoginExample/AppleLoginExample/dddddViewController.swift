//
//  dddddViewController.swift
//  AppleLoginExample
//
//  Created by 신용철 on 2020/03/25.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import UIKit

class dddddViewController: UIViewController {
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.setTitle("dddd", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        button.layer.cornerRadius = button.bounds.width / 2  //버튼모양 둥글게
        button.addTarget(self, action: #selector(download), for: .touchUpInside)
    }
    
    
    func encodedData() -> Data? {
        let account = LoginInfo(username: "용철", email: "sy@naver.com", password: "ㅇㅇㅇ")
        var data: Data?
        do{
            let accountData = try JSONEncoder().encode(account)
            data = accountData
        } catch {
            print(error)
        }
        return data
    }
    
    @objc func upload(){
        guard let requestURL = URL(string: "http://13.209.3.115:88/members/signup/") else {return}
        
        var request = URLRequest(url: requestURL)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedData()
        
        URLSession.shared.dataTask(with: request).resume()
        
    }
    
    @objc func download(){
        guard let requestURL = URL(string: "http://13.209.3.115:88/members/user-list/") else {return}
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            guard let data = data else {print("데이터 없음"); return}
            
            guard let aaa = try? JSONDecoder().decode([UserInfo].self, from: data) else {print("디코드 실패");return}
            print(aaa)
            
        }.resume()
    }
}

struct LoginInfo: Codable {
    let username: String
    let email: String
    let password: String
}

struct UserInfo: Codable {
    let pk: Int
    let email: String
}
