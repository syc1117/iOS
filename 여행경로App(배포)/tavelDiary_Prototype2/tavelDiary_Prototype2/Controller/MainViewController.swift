//
//  ViewController.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/01/24.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let tableView = UITableView()
    let emptyView = UIView() //첫번째 화면에 컨텐츠가 없을때 보여주는 화면
    let writeButton: UIButton = {
        let button = UIButton()
        button.setTitle("새로운 여행목록을 \n작성해보세요!", for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 10
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        button.addTarget(self, action: #selector(didTouchAddButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.title = "여행목록"
        navigationController?.navigationBar.prefersLargeTitles = true
        let rightBarButton = UIBarButtonItem(title: "새 여행", style: .done, target: self, action: #selector(didTouchAddButton))
        navigationItem.rightBarButtonItem = rightBarButton
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataBase.shared.fetchData {
            self.tableView.reloadData()
        }
        
        //저장된 값이 있으면 초기화면을 테이블뷰로 표현, 값이 없으면 안내 화면 표현
        if DataBase.shared.data.isEmpty {
            self.emptyView.isHidden = false
            self.tableView.isHidden = true
        } else {
            emptyView.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.tableView.reloadData()
//    }

     @objc private func didTouchAddButton(){
            let WVC = WriteViewController()
            navigationController?.pushViewController(WVC, animated: true)
    //         는 뒤로가기. dismiss는 present에만 사용할 수 있음.
    //        navigationController?.popToRootViewController(animated: true) // 최초화면으로 이동
        }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBase.shared.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCustomCell
        let cellData = DataBase.shared.data[indexPath.row]
        cell.selectionStyle = .none
        cell.titleLabel2.text = cellData.tripTitle
        //날짜가 없을 때 " ~ "가 표시되는 것을 막기 위함
        if !cellData.startingDate.isEmpty, !cellData.endDate.isEmpty
        {
            cell.scheduleLabel2.text = "\(cellData.startingDate) ~ \(cellData.endDate)"
        }
       
        cell.pathLabel2.text = cellData.navigationLabel
        cell.memoLabel2.text = cellData.memo
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    //    선택한 셀의 index에 해당하는 값을 DetailViewController로 넘겨줘야함
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dvc = DetailViewController()
        dvc.data = DataBase.shared.data[indexPath.row]
        dvc.title = DataBase.shared.data[indexPath.row].tripTitle
        navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: Setup UI
extension MainViewController {
    func setupUI(){
        view.addSubviews([tableView, emptyView])
        emptyView.addSubview(writeButton)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.separatorStyle = .none
        tableView.register(MainCustomCell.self, forCellReuseIdentifier: "cell")
        tableView.layout.top(constant: 10).bottom().leading(constant: 15).trailing(constant: -15)
        
//        tableView.frame = view.frame
        //emptyView 설정
        emptyView.layout.top().leading().trailing().bottom()
        emptyView.backgroundColor = .white
        
        writeButton.layout.leading(equalTo: emptyView.leadingAnchor).trailing(equalTo: emptyView.trailingAnchor).centerY(equalTo: emptyView.centerYAnchor)
        writeButton.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
