//
//  SearchViewController.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/03.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import AVKit

extension Notification.Name {
    static let killTheZico = Notification.Name("killTheZico")
}

class SearchViewController: UIViewController {
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
            print("----------검색viewWillDisappear------------")
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
            print("----------검색viewDidDisappear------------")
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("----------검색viewWillAppear------------")
    }
    
    let notiManger = UserNoti()
    let tableView = UITableView()
    let subTableView = UITableView()
    let searchBar = UISearchBar()
    var avplayer: AVPlayer?
    var tracks: [Track] = []
    var isPlaying = true
    var song: Track? {
        didSet {
            self.subTableView.reloadData()
        }
    }
    // MARK: cmTime -> playerView 전용 프로퍼티들
    var timeObserver: Any?
    
    var currentTime: Double {
        return avplayer?.currentItem?.currentTime().seconds ?? 0
    }
    //avplayer에 currentItem을 통해 전체 재생 시간 정보(duration)를 가져올 수 있음. 타입은 Double.
    var totalDurationTime: Double {
        return avplayer?.currentItem?.duration.seconds ?? 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------검색viewDidLoad------------")
        view.addSubviews([tableView, subTableView, searchBar])
        subTableView.isHidden = true
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        subTableView.rowHeight = 60
        tableView.tag = 0
        subTableView.tag = 1
        subTableView.delegate = self
        subTableView.dataSource = self
        
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
        subTableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerTableViewCell")
        
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
        
        subTableView.layout.bottom().trailing().leading()
        subTableView.heightAnchor.constraint(equalToConstant: 61).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusic), name: .stopMusic, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusic), name: .stopMusic3, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playMusic), name: .play, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didTabLikeButton), name: .likeNotification, object: nil)
    }
    
    @objc func didTabLikeButton(){
        
        // alert띄워서 수락하면  ==>> 저장함
        // indexPath 정보가 없어.
        // 클릭한 버튼이 들어있는 Cell의 indexPath정보를 어떻게든 끌고 와야되는 상황.
        
    }
    
    @objc func stopMusic(){
        self.avplayer?.pause()
    }
    @objc func playMusic(){
        self.avplayer?.play()
    }
}
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        guard let searchText = searchBar.text, searchText.isEmpty == false else { return }
        searchingMusic(searchText)
    }
    
    func searchingMusic(_ searchText: String){
        self.searchBar.text = searchText
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search?media=music&entity=song")!
        let queryItem = URLQueryItem(name: "term", value: searchText)
        urlComponents.queryItems?.append(queryItem)
        
        guard let requestURL = urlComponents.url else { return print("url 에러") }
        
        URLSession.shared.dataTask(with: requestURL) { [weak self] (data, response, error) in
            
            guard let strongSelf = self else { return }
            guard error == nil else { return }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            let successRange = 200 ..< 300
            
            guard successRange.contains(statusCode) else { return print("서버 결과코드 에러") }
            
            guard let resultData = data else { return print("데이터 없음")}
            strongSelf.tracks = strongSelf.parsing(resultData) ?? []
            
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }.resume()
    }
    
    func parsing(_ track: Data) -> [Track]?{
        do {
            let decoder = JSONDecoder()
            let response = try decoder.decode(Response.self, from: track)
            let trackList = response.results
            return trackList
        } catch let error {
            print("---> error:\(error.localizedDescription)")
            return nil
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return tracks.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 0 {
            let url = URL(string: tracks[indexPath.row].thumbnail)!
            guard let data = try? Data(contentsOf: url),
                let img = UIImage(data: data) else { return UITableViewCell()}
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
            cell.configure(img1: img, title: tracks[indexPath.row].title, name: tracks[indexPath.row].artistName)
            cell.selectionStyle = .none
            return cell
        } else {
            if let song = self.song,
                let url = URL(string: song.thumbnail),
                let data = try? Data(contentsOf: url),
                let img = UIImage(data: data)
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
                cell.configure(img1: img, title: song.title, name: song.artistName)
                cell.backgroundColor = #colorLiteral(red: 0.9291113615, green: 0.7605398297, blue: 0.9382160306, alpha: 1)
                cell.selectionStyle = .none
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(Notification(name: .killTheZico))
        let track = tracks[indexPath.row]
        if tableView.tag == 0 {
        prepareToPlay(track)
        guard let url = track.previewUrl else { return }
        MusicData.shared.addMusicData(title: track.title, artistName: track.artistName, thumbnail: track.thumbnail, previewUrl: url)
        triggerTimeIntervalNotification(track)
        
        //        playingMusic(tracks[indexPath.row])
        self.isPlaying = true
        self.subTableView.isHidden = false
        self.song = track
        self.subTableView.reloadData()
        NotificationCenter.default.post(Notification(name:.stopMusic2))
        NotificationCenter.default.post(name: .isPlaying, object: nil, userInfo: ["isPlaying": self.isPlaying])
        } else {
            let pvc = PlayViewController()
            avplayer?.pause()
            pvc.track = self.song
//            pvc.currentTime = self.currentTime
//            pvc.totalDurationTime = self.totalDurationTime
            present(pvc, animated: true)
        }
    }
    func prepareToPlay(_ track: Track){
        guard let url = track.previewUrl else { return }
        guard let previewURL = URL(string: url) else { return }
        let player = AVPlayer(url: previewURL)
        self.avplayer = player
        avplayer?.play()
    }
    func triggerTimeIntervalNotification(_ track: Track) {
        let notificationTitle = track.title
        if let url = URL(string: track.thumbnail) {
        notiManger.thisIsNoti(
            with: notificationTitle, timeInterval: TimeInterval(1), imgUrl: url)
        }
    }
    
}


