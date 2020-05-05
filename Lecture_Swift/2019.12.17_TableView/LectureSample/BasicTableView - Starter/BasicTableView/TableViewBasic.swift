//
//  TableViewBasic.swift
//  BasicTableView
//
//  Created by Giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewBasic: UIViewController {
  
  override var description: String { "TableView - Basic" }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tableView = UITableView(frame: view.frame)
    view.addSubview(tableView)
//    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
    //UITableViewCell.self : UITableVeiwCell()이라는 인스턴스를 사용하겠다는 것이 아니고 UITableVeiwCell타입을 사용하겠다는 것이므로 .self를 뒤에 붙여서 사용.
  }
}


extension TableViewBasic: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
//        cell.textLabel?.text = "\(indexPath.row)"
        
        return UITableViewCell()
    }
    
    
}



