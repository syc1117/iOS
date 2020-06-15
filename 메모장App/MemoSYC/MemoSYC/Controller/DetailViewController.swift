//
//  DetailViewController.swift
//  MemoSYC
//
//  Created by 신용철 on 2020/06/15.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_kr")
        f.dateStyle = .long
        f.timeStyle = .short
        return f
    }()
    
    var memo: Memo?
    
    let tableView = UITableView()
    let toolbar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI ()
        
    }
    
  
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.textLabel?.text = self.memo?.content
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
        } else {
            cell.textLabel?.text = self.dateFormatter.string(for: self.memo?.insertDate)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .gray
        }
        
        return cell
    }
}

extension DetailViewController {
    func setupUI () {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        view.addSubviews([tableView, toolbar])
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.layout.top().leading().trailing().bottom(equalTo: self.toolbar.topAnchor)
        self.toolbar.layout.bottom().leading().trailing()
        
        let editMemoButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(toolBarButton))
        editMemoButton.tag = 0
        
        let deleteMemoButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(toolBarButton))
        deleteMemoButton.tag = 1
        
        let shareMemoButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(toolBarButton))
        shareMemoButton.tag = 2
        
        let flexibleSpacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        self.toolbar.setItems([editMemoButton, flexibleSpacing, deleteMemoButton, flexibleSpacing, shareMemoButton], animated: true)
    }
    
    @objc func toolBarButton(sender: UIBarButtonItem) {
        switch sender.tag {
        case 0:
            navigationController?.pushViewController(ComposeViewController(), animated: true)
            guard let cv = navigationController?.viewControllers[2] as? ComposeViewController else {
                       return
                   }
            cv.editTarget = self.memo
        case 1:
            let alert = UIAlertController(title: "삭제 확인", message: "메모를 삭제할까요?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "삭제", style: .destructive) {[weak self] (action) in
                DataManager.shared.deleteMemo(self?.memo)
                self?.navigationController?.popToRootViewController(animated: true)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
            
        case 2:
            guard let memo = memo?.content else { return }
            let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
            present(vc, animated: true)
            
        default:
            fatalError()
        }
    }
}
