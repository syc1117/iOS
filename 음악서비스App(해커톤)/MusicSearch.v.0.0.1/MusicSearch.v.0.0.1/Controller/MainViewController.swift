//
//  ViewController.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/03.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import AVFoundation
// MARK: 최신음악 collectionView
extension Notification.Name {
    static let stopMusic = Notification.Name("stopMusic")
    static let stopMusic2 = Notification.Name("stopMusic2")
    static let stopMusic3 = Notification.Name("stopMusic3")
    static let showCollectionView = Notification.Name("showCollectionView")
}
class MainViewController: UIViewController {
    let musicData = MusicData.shared.musicData
    let subTableView = UITableView()
    
    let layout2 = UICollectionViewFlowLayout()
    let layout = UICollectionViewFlowLayout()
    
    lazy var collectionViewForRecentMusic = UICollectionView(frame: self.recentView.frame, collectionViewLayout: self.layout)
    lazy var collectionViewForMyPlayList = UICollectionView(frame: self.playView.frame, collectionViewLayout: self.layout2)
    
    let recentView = UIView()
    let recentLabel = UILabel()
    let playLabel = UILabel()
    let playView = UIView()
    let label = UILabel() //플레이 리스트 없을 때 "없다"고 알려주는 레이블
    // MARK: asset파일에 추가한 음악 재생
    var avplayer: AVPlayer?
    var isPlaying = true
    var song: MusicCoreData? {
        didSet {
            self.subTableView.reloadData()
        }
    }
    
    let musicList = [
        Track2(title: "아무노래", thumb: #imageLiteral(resourceName: "아무노래"), artist: "지코"),
        Track2(title: "교차로 (Crossroads)", thumb: #imageLiteral(resourceName: "교차로 (Crossroads)"), artist: "여자친구"),
        Track2(title: "헛소리", thumb: #imageLiteral(resourceName: "헛소리"),artist: "김종헌"),
        Track2(title: "미안해 엄마 (Sorry Mama)", thumb: #imageLiteral(resourceName: "미안해 엄마 (Sorry Mama)"), artist: "다크비(DKB)"),
        Track2(title: "DUN DUN", thumb: #imageLiteral(resourceName: "EVERGLOW (에버글로우)_DUN DUN"), artist: "EVERGLOW (에버글로우)"),
        Track2(title: "replay (prod. by Tommy Strate)", thumb: #imageLiteral(resourceName: "replay (prod. by Tommy Strate)"), artist: "Tommy Strate"),
        Track2(title: "psycho (Feat. 빈센트블루)", thumb: #imageLiteral(resourceName: "psycho (Feat. 빈센트블루)"), artist: "키디비 (KittiB)")
    ]
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------viewDidload------------")
        MusicData.shared.fetchMusicData()
        setupLayout()
        setupCollectionView ()
        view.addSubview(subTableView)
        subTableView.isHidden = true
        subTableView.rowHeight = 60
        subTableView.delegate = self
        subTableView.dataSource = self
        subTableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerTableViewCell")
        subTableView.layout.bottom().trailing().leading()
        subTableView.heightAnchor.constraint(equalToConstant: 61).isActive = true
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .refreshNoti, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusic), name: .stopMusic, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusic), name: .stopMusic2, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showCollectionView), name: .showCollectionView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playmusic), name: .play, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteZico), name: .killTheZico, object: nil)
        
    }
    
    @objc func deleteZico(){
        self.avplayer = nil
    }
    
    @objc func refresh(){
        collectionViewForMyPlayList.reloadData()
    }
    @objc func stopMusic(){
        self.avplayer?.pause()
        
    }
    @objc func playmusic(){
        self.avplayer?.play()
    }
    @objc func showCollectionView(){
        self.collectionViewForMyPlayList.isHidden = false
        playView.bringSubviewToFront(collectionViewForMyPlayList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         print("----------viewWillAppear------------")
        if MusicData.shared.musicData.count == 0 {
            let imageView = UIImageView()
            playView.addSubview(imageView)
            imageView.layout.top().bottom().trailing().leading()
            imageView.image = #imageLiteral(resourceName: "playViewBackground")
            playView.clipsToBounds = true
            self.playView.addSubview(label)
            self.label.textColor = .white
            //            self.playView.backgroundColor = #colorLiteral(red: 0.8113562465, green: 0.5033165216, blue: 1, alpha: 1)
            self.label.text = "생성된 플레이 리스트가 없습니다."
            self.label.font = UIFont.systemFont(ofSize: 25)
            self.label.textAlignment = .center
            label.layout.centerX().centerY(constant: 100)
            label.isHidden = false
        } else {
            collectionViewForMyPlayList.isHidden = false
            label.isHidden = true
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         print("----------viewWillDisappear------------")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
         print("----------viewDidDisappear------------")
    }
    
    // MARK: asset파일에 추가한 음악 재생하기 위한 player 세팅
    func prepareToPlay(_ track: Track2?){
        guard let currentTrack = track else {return}
        let asset = currentTrack.asset
        let playerItem = AVPlayerItem(asset: asset) //AV
        let player = AVPlayer(playerItem: playerItem)
        self.avplayer = player
    }
    
    func setupCollectionView (){
        collectionViewForRecentMusic.dataSource = self
        collectionViewForRecentMusic.delegate = self
        collectionViewForMyPlayList.dataSource = self
        collectionViewForMyPlayList.delegate = self
        
        collectionViewForRecentMusic.tag = 0
        collectionViewForMyPlayList.tag = 1
        
        recentView.addSubview(collectionViewForRecentMusic)
        playView.addSubview(collectionViewForMyPlayList)
        
        // MARK: 나의 플레이리스트가 없으면 collectionView 숨김
        if MusicData.shared.musicData.count == 0 {
            collectionViewForMyPlayList.isHidden = true
        } else {
            collectionViewForMyPlayList.isHidden = false
            
        }
        
        // MARK: collection view auto Layout
        collectionViewForRecentMusic.layout.top().leading().trailing().bottom()
        collectionViewForMyPlayList.layout.top().leading().trailing().bottom()
        
        collectionViewForRecentMusic.backgroundColor = .white
        collectionViewForMyPlayList.backgroundColor = .white
        
        
        
        // MARK: cell 등록
        collectionViewForMyPlayList.register(MainPlayCell.self, forCellWithReuseIdentifier: "MainPlayCell")
        collectionViewForRecentMusic.register(RecentMusicCell.self, forCellWithReuseIdentifier: "RecentMusicCell")
        
        
        // MARK: collectionViewForRecentMusic 레이아웃 설정
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 150, height: 190)
        
        
        // MARK: collectionViewForMyPlayList 레이아웃 설정
        layout2.minimumInteritemSpacing = 10
        layout2.minimumLineSpacing = 10
        layout2.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let totalSpacing = layout2.sectionInset.right + layout2.sectionInset.left + layout2.minimumInteritemSpacing + 30
        let width = (view.frame.width - totalSpacing) / 3
        let roundedWidth = width.rounded(.down)
        layout2.itemSize = CGSize(width: roundedWidth, height: roundedWidth + 40)
    }
    
    func setupLayout(){
        view.addSubviews([playView, recentView, recentLabel, playLabel])
        
        recentLabel.layout.top(constant: 15).leading(constant: 20).trailing()
        recentLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        recentLabel.text = "최신음악"
        
        recentLabel.textAlignment = .left
        recentLabel.textColor = .black
        recentLabel.font = UIFont.systemFont(ofSize: 25)
        
        recentView.layout.leading().top(equalTo: recentLabel.bottomAnchor, constant: 10).trailing()
        recentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        playLabel.layout.leading(constant: 20).trailing().top(equalTo: recentView.bottomAnchor, constant: 45)
        playLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        playLabel.text = "나의 플레이리스트"
        playLabel.textAlignment = .left
        playLabel.textColor = .black
        playLabel.font = UIFont.systemFont(ofSize: 25)
        
        playView.layout.leading(constant: 10).trailing(constant: -10).top(equalTo: playLabel.bottomAnchor, constant: 15).bottom(constant: -10)
        playView.layer.cornerRadius = 20
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return MusicData.shared.musicData.count
        } else {
            return musicList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let music = MusicData.shared.musicData[indexPath.item]
            let url = URL(string: music.thumbnail ?? "")!
            guard let data = try? Data(contentsOf: url),
                let img = UIImage(data: data),
                let title = music.title,
                let name = music.artistName else { return UICollectionViewCell()}
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPlayCell", for: indexPath) as? MainPlayCell else { return UICollectionViewCell()}
            cell.configure(img1: img, title: title, name: name)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentMusicCell", for: indexPath) as! RecentMusicCell
            let music = musicList[indexPath.item]
            cell.configure(img1: music.thumb, title: music.title, name: music.artist)
            cell.clipsToBounds = true
            return cell
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            self.prepareToPlay(self.musicList[indexPath.item])
            self.avplayer?.play()
            NotificationCenter.default.post(Notification(name:.stopMusic3))
        } else {
            self.avplayer = nil
            let track = MusicData.shared.musicData[indexPath.row]
            prepareToPlay(track)
            self.song = track
            self.isPlaying = true
            self.subTableView.isHidden = false
            //            self.subTableView.reloadData()
            NotificationCenter.default.post(name: .isPlaying, object: nil, userInfo: ["isPlaying": self.isPlaying])
            NotificationCenter.default.post(Notification(name:.stopMusic3))
        }
    }
    func prepareToPlay(_ track: MusicCoreData){
        guard let url = track.previewUrl else { return }
        guard let previewURL = URL(string: url) else { return }
        let player = AVPlayer(url: previewURL)
        self.avplayer = player
        avplayer?.play()
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        cell.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pvc = PlayViewController()
        avplayer?.pause()
        guard let title = self.song?.title,
            let name = self.song?.artistName,
            let thumbnail = self.song?.thumbnail,
            let url = self.song?.previewUrl else { return }
        let music = Track(title: title, artistName: name, thumbnail: thumbnail, previewUrl: url)
        pvc.track = music
        present(pvc, animated: true)
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let song = self.song,
            let url = URL(string: song.thumbnail!),
            let data = try? Data(contentsOf: url),
            let img = UIImage(data: data),
            let title = song.title,
            let name = song.artistName
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath) as! PlayerTableViewCell
            cell.configure(img1: img, title: title, name: name)
            cell.backgroundColor = #colorLiteral(red: 0.9291113615, green: 0.7605398297, blue: 0.9382160306, alpha: 1)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
}
