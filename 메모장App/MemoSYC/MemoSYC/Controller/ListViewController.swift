//
//  ViewController.swift
//  MemoSYC
//
//  Created by 신용철 on 2020/06/14.
//  Copyright © 2020 신용철. All rights reserved.
//


import UIKit

class ListViewController: UIViewController {
    
    let tableView = UITableView()
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_kr")
        f.dateStyle = .long
        f.timeStyle = .short
        return f
    }()
    
    var token: NSObjectProtocol?
    
    //화면이 사라질 때 추가된 옵저버(token)을 해제하지 않으면 화면이 다시 열릴 때마다 중복되어 생성됨으로서 메모리에 누수가 발생함.
    deinit {
        if let token = self.token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataManager.shared.fetchMemo()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        
        //후행 클로저의 내용이 아래와 같이 지정한 queue에 전달되어 실행됨.
        //addObserver는 옵저버 해제할 대상을 return해주는데 이를 token이라고 부름.
        self.token = NotificationCenter.default.addObserver(forName: ComposeViewController.newMemoDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
//            DataManager.shared.fetchMemo() <<로 사용해도 되지만 불필요한 데이터 작업을 줄이기 위해 DataManager의 addNewMemo함수에 memoList로 곧바로 넣어주는 코드 구현하였음.
            self?.tableView.reloadData()
        }
    }
    
    @objc func newMemo() {
        let cv = UINavigationController(rootViewController: ComposeViewController())
        present(cv, animated: true)
    
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.memoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //subtitle 형태로 재사용하되 없으면 만들겠다는 것. 메모리 누수 방지
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let target = DataManager.shared.memoList[indexPath.row]
        cell.textLabel?.text = target.content
        cell.detailTextLabel?.text = dateFormatter.string(for: target.insertDate)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(), animated: true)
        let target = DataManager.shared.memoList[indexPath.row]
        guard let dvc = navigationController?.viewControllers[1] as? DetailViewController else {
            return
        }
        dvc.memo = target
    }
    
    // MARK: swipe로 테이블뷰 데이터 삭제하는 기능 구현
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let target = DataManager.shared.memoList[indexPath.row]
            DataManager.shared.deleteMemo(target)
            //아래 코드를 생략할 경우, 테이블뷰 상에 표시된 데이터의 갯수와 실제로 테이블뷰에 데이터를 뿌려주는 배열의 개수가 차이가 나면서 에러가 발생하게 됨.
            DataManager.shared.memoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ListViewController {
    func setupUI() {
        self.title = "메모목록"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let addMemo = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newMemo))
        navigationItem.rightBarButtonItem = addMemo
    }
    
    func setupTableView() {
        view.addSubview(self.tableView)
        self.tableView.frame = view.frame
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
   
}
