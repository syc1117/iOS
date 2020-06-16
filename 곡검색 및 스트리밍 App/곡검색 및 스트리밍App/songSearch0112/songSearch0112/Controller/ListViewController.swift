//
//  ViewController.swift
//  songSearch0112
//
//  Created by 신용철 on 2020/01/12.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import AVKit
import Firebase

class ListViewController: UIViewController, HistoryViewDelegate {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    var trackList: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.shared.fetchWatchHistory{
            self.tableView.reloadData()
        }
        FirebaseManager.shared.fetchSearchHistory{
            self.tableView.reloadData()
        }
        view.addSubview(tableView)
        view.addSubview(searchBar)
        tableView.frame = view.frame
        searchBar.sizeToFit()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let history = UIBarButtonItem(title: "History", style: .plain, target: self, action: #selector(historyButton))
        navigationItem.rightBarButtonItem = history
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive  = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive  = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive  = true
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive  = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive  = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive  = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive  = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    @objc func historyButton(_ sender: UIBarButtonItem){
        let hvc = HistoryViewController()
        hvc.delegate = self
        navigationController?.pushViewController(hvc, animated: true)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clickedCell = trackList[indexPath.row]
        play(clickedCell)
    }
    
    func play(_ track: Track){
        guard let previewURL = URL(string: track.previewUrl!) else { return }
        let playerViewController = AVPlayerViewController()
        present(playerViewController, animated: true, completion: nil)
        let player = AVPlayer(url: previewURL)
        playerViewController.player = player
        player.play()
        FirebaseManager.shared.saveWatchHistory(track)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let reusable = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell = reusable
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell.textLabel?.text = trackList[indexPath.row].title
        cell.detailTextLabel?.text = trackList[indexPath.row].artistName
        return cell
    }
}

extension ListViewController: UISearchBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        searching(searchText)
    }
    func searching(_ searchText: String){
        var urlComponent = URLComponents(string: "https://itunes.apple.com/search?media=music&entity=musicVideo")!
        let queryItem = URLQueryItem(name: "term", value: searchText)
        urlComponent.queryItems?.append(queryItem)
        let requestURL = urlComponent.url!
        
        URLSession.shared.dataTask(with: requestURL) {[weak self] (data, response, error) in
            guard let strongSelf = self else { return}
            
            guard error == nil else { return }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200 ..< 300
            guard successRange.contains(statusCode) else { return }
            guard let resultData = data else { return }
            print(resultData)
            strongSelf.trackList = strongSelf.parse(resultData) ?? []
            FirebaseManager.shared.saveSearchHistroy(searchText)
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }.resume()
    }
    func parse(_ data: Data) -> [Track]?{
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            let trackArray = response.results
            return trackArray
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

