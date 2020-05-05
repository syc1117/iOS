//
//  TableViewEditing.swift
//  BasicTableView
//
//  Created by Giftbot on 2019/12/05.
//  Copyright © 2019 giftbot. All rights reserved.
//

import UIKit

final class TableViewEditing: UIViewController {
    
    /***************************************************
     테이블뷰 목록 수정하기 (insert, delete 등)
     ***************************************************/
    
    override var description: String { "TableView - Editing" }
    
    let tableView = UITableView()
    var data = Array(1...50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Edit", style: .plain, target: self, action: #selector(switchToEditing)
        )
    }
    
    func setupTableView() {
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        view.addSubview(tableView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...")
        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func reloadData() {
        tableView.refreshControl?.endRefreshing()
        tableView.reloadData()
    }
    
    @objc func switchToEditing() {
        //tableView의 편집모드 활성화: !tableView.isEditing를 통해 편집상태가 아닐때 편집모드 실행, 편집상태일때 작동 안함 설정
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension TableViewEditing: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell.textLabel?.text = "\(data[indexPath.row])"
        return cell
    }
}


// MARK: - UITableViewDelegate

extension TableViewEditing: UITableViewDelegate {
    
    //commit editingStyle을 활성화 하면 테이블뷰에서 왼쪽으로 swipe시 delete버튼이 활성화 됨.
    //editing 종류에 따른 작동 방식 구현
    //삭제, 삽입 모두 tableView의 data를 먼저 수정하고 표시되는 ui를 수정해야 오류나지 않음.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("delete")
        case .insert: print("insert")
        let random = (0...50).randomElement()!
        data.insert(random, at: indexPath.row)
        tableView.insertRows(at: [indexPath], with: .top)
        default: print("none")
        }
    }
    //아래 함수 구현 안하면 모든 셀의 편집 모드는 delete로 구현됨.
    //insert기능 구현을 위해서는 아래에서 코딩작업 필요
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row % 3 == 0 {
            return .insert
        } else if indexPath.row % 3 == 1 {
            return .delete
        } else {
            return .none
        }
    }
    
    //cell을 swipe할 때 어떤 기능을 수행하게 할 지 설정해줄 수 있음.
    //tableView.setEditing(!tableView.isEditing, animated: true)와 겹쳐서 쓸 때 기능이 상충되지 않도록 잘 조정해야 함.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Add") { (action, sourceView, actionPerformed) in
            let random = (0...50).randomElement()!
            self.data.insert(random, at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .top)
        }
        addAction.backgroundColor = .green
        let DeleteAction = UIContextualAction(style: .destructive, title: "delete") { (action, sourceView, actionPerformed) in
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        if indexPath.row % 3 == 0{
            return UISwipeActionsConfiguration(actions: [addAction])
        } else if indexPath.row % 3 == 1 {
            return UISwipeActionsConfiguration(actions: [DeleteAction])
        } else {
            let config = UISwipeActionsConfiguration(actions: [addAction, DeleteAction])
            config.performsFirstActionWithFullSwipe = false
            return config
        }
    }
    //왼쪽 스와이핑
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let addAction = UIContextualAction(style: .normal, title: "Add") { (action, sourceView, actionPerformed) in
            let random = (0...50).randomElement()!
            self.data.insert(random, at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .top)
        }
        addAction.backgroundColor = .green
        let DeleteAction = UIContextualAction(style: .destructive, title: "delete") { (action, sourceView, actionPerformed) in
            self.data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        if indexPath.row % 3 == 0{
            return UISwipeActionsConfiguration(actions: [addAction])
        } else if indexPath.row % 3 == 1 {
            return UISwipeActionsConfiguration(actions: [DeleteAction])
        } else {
            let config = UISwipeActionsConfiguration(actions: [addAction, DeleteAction])
            config.performsFirstActionWithFullSwipe = false
            return config
        }
    }
}

