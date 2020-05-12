//
//  TableView03.swift
//  BasicTableView
//
//  Created by Giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewRefresh: UIViewController {
  
  override var description: String { "TableView - Refresh" }
  
  /***************************************************
   테이블뷰를 새로 불러올 때마다 숫자 목록을 반대로 뒤집어서 출력하기
   ***************************************************/
  
  let tableView = UITableView()
  var data = Array(1...40)
  
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "refresh", style: .plain, target: self, action: #selector(reloadData))
    
    tableView.rowHeight = 80 // 테이블뷰 칸 높이 설정
    
    
  }
  
  func setupTableView() {
    tableView.frame = view.frame
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    view.addSubview(tableView)
    
    
    let refreshcontrol = UIRefreshControl() //로딩 애니매이션 추가
    refreshcontrol.attributedTitle = NSAttributedString(string: "refreshing...", attributes: [.font:UIFont.systemFont(ofSize: 30), .kern: 5
    ])
    refreshcontrol.tintColor = .blue
    refreshcontrol.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    tableView.refreshControl = refreshcontrol
    
  }
  
  @objc func reloadData() {
    data.reverse()
    tableView.refreshControl?.endRefreshing()//위에 코딩 다 실행되고 나면 빙빙도는거 사라짐.
    tableView.reloadData()
    
    print("click")
  }
}

// MARK: - UITableViewDataSource

extension TableViewRefresh: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    cell.textLabel?.text = "\(data[indexPath.row])"
    return cell
  }
}
