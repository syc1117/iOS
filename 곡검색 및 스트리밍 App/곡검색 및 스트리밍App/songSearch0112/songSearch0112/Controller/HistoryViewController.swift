//
//  HistoryViewController.swift
//  songSearch0112
//
//  Created by 신용철 on 2020/01/12.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController  {
    
    var sectionTitle = ["검색이력", "재생이력"]
    let tableView = UITableView()
    weak var delegate: HistoryViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.shared.fetchWatchHistory{
            self.tableView.reloadData()
        }
        FirebaseManager.shared.fetchSearchHistory{
            self.tableView.reloadData()
        }
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HistoryViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let searchText = FirebaseManager.shared.searchHistory[indexPath.row]
            delegate?.searching(searchText)
            navigationController?.popViewController(animated: true)
        } else {
            let watchTrack = FirebaseManager.shared.wathchHistory[indexPath.row]
                delegate?.play(watchTrack)
        }
    }
}

protocol HistoryViewDelegate: class {
    func play(_ track: Track)
    func searching(_ searchText: String)
}

extension HistoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let searchArray = FirebaseManager.shared.searchHistory
        let watchArray = FirebaseManager.shared.wathchHistory
        if section == 0 {
            return searchArray.count
        } else {
            return watchArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        let searchArray = FirebaseManager.shared.searchHistory
        let watchArray = FirebaseManager.shared.wathchHistory
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = reusableCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
        if indexPath.section == 0 {
            cell.textLabel?.text = searchArray[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = watchArray[indexPath.row].title
            cell.detailTextLabel?.text = watchArray[indexPath.row].artistName
        }
        return cell
    }
}

