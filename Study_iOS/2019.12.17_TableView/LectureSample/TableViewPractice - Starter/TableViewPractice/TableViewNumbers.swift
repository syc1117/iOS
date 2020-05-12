//
//  TableViewNumbers.swift
//  TableViewPractice
//
//  Created by giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewNumbers: UIViewController {
    
    /***************************************************
     1부터 50까지의 숫자 출력하기
     ***************************************************/
    
    override var description: String { "Practice 1 - Numbers" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
    }
}

extension TableViewNumbers: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //신규 및 재사용
//        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") {
//            cell.textLabel?.text = "\(indexPath.row + 1)"
//            return cell
//        } else {
//            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell2")
//            cell.textLabel?.text = "\(indexPath.row + 1)"
//            return cell
//        }
        
        //재사용
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
    
}
