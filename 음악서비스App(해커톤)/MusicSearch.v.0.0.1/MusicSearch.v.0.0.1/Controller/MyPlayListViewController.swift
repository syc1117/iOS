//
//  MyPlayListViewController.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/03.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import AVFoundation

class MyPlayListViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("----------보관함viewWillAppear------------")
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
            print("----------보관함viewWillDisappear------------")
       }
       
       override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
            print("----------보관함viewDidDisappear------------")
       }
    
    let backgroundView = UIView()
    let backgroundView2 = UIView()
    let layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: backgroundView.frame , collectionViewLayout: layout)
    let titleLabel = UILabel()
    var avplayer: AVPlayer?
    var totalDurationTime: Double {
        return avplayer?.currentItem?.duration.seconds ?? 0
    }
    var totalMusicList = MusicData.shared.musicData
    let playAllButton = UIButton()
    let tableView = UITableView()
    let subTableView = UITableView()
    var song: MusicCoreData? {
        didSet {
            self.subTableView.reloadData()
        }
    }
    var isPlaying = true
    var isCollectionView = true
    
    let changeUIButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "change"), for: .normal)
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(changingView), for: .touchUpInside)
        return button
    }()
    
    @objc func changingView(){
        if isCollectionView {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            tableView.reloadData()
        }
        isCollectionView.toggle()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------보관함viewDidLoad------------")
        setupLayout()
        setupCollectionView()
        settupTableView()
        
        view.addSubview(subTableView)
        subTableView.delegate = self
        subTableView.dataSource = self
        tableView.tag = 0
        subTableView.tag = 1
        subTableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerTableViewCell")
        subTableView.rowHeight = 60
        subTableView.layout.bottom().trailing().leading()
        subTableView.heightAnchor.constraint(equalToConstant: 61).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .refreshNoti, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusic), name: .stopMusic2, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopMusic), name: .stopMusic3, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playmusic), name: .play, object: nil)
    }
    
    @objc func refresh(){
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    @objc func playmusic(){
        self.avplayer?.play()
    }
    
    @objc func stopMusic(){
        self.avplayer?.pause()
    }
}

extension MyPlayListViewController {
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(MainPlayCell.self, forCellWithReuseIdentifier: "MainPlayCell")
        collectionView.layout.top().leading().trailing().bottom()
    }
}

extension MyPlayListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MusicData.shared.musicData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let music = MusicData.shared.musicData[indexPath.item]
        let url = URL(string: music.thumbnail ?? "")!
        guard let data = try? Data(contentsOf: url),
            let img = UIImage(data: data),
            let title = music.title,
            let name = music.artistName else { return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPlayCell", for: indexPath) as! MainPlayCell
        cell.configure(img1: img, title: title, name: name)
        return cell
    }
}

extension MyPlayListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(Notification(name: .killTheZico))
        let track = MusicData.shared.musicData[indexPath.item]
        prepareToPlay(track)
        NotificationCenter.default.post(Notification(name:.stopMusic))
        self.song = track
        self.isPlaying = true
        self.subTableView.isHidden = false
        //            self.subTableView.reloadData()
        NotificationCenter.default.post(name: .isPlaying, object: nil, userInfo: ["isPlaying": self.isPlaying])
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
        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
            cell.transform = .identity
        }
    }
}

extension MyPlayListViewController {
    func setupLayout(){
        view.addSubviews([backgroundView, changeUIButton,titleLabel])
        backgroundView.addSubview(collectionView)
        
        changeUIButton.layout.top(constant: 20).trailing(constant: -20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        let totalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing * 2
        let width = (view.frame.width - totalSpacing) / 3
        let roundedWidth = width.rounded(.down)
        
        layout.itemSize = CGSize(width: roundedWidth, height: roundedWidth + 40)
        
        titleLabel.layout.top(constant: 20).leading(constant: 20).trailing()
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.text = "나의 플레이리스트"
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 30)
        
        backgroundView.layout.top(equalTo: titleLabel.bottomAnchor, constant: 30).trailing().bottom().leading()
        
        
    }
}

extension MyPlayListViewController: UITableViewDataSource {
    func settupTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.layout.top(equalTo: titleLabel.bottomAnchor, constant: 30).trailing().bottom().leading()
        tableView.register(MyPlayTableViewCell.self, forCellReuseIdentifier: "MyPlayTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0 {
            return MusicData.shared.musicData.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let music = MusicData.shared.musicData[indexPath.item]
        if tableView.tag == 0 {
            let url = URL(string: music.thumbnail ?? "")!
            guard let data = try? Data(contentsOf: url),
                let img = UIImage(data: data),
                let title = music.title,
                let name = music.artistName else { return UITableViewCell()}
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyPlayTableViewCell", for: indexPath) as! MyPlayTableViewCell
            
            cell.configure(img1: img, title: title, name: name)
            
            return cell
        } else { if let song = self.song,
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
}
extension MyPlayListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(Notification(name: .killTheZico))
        if tableView.tag == 0 {
            prepareToPlay(MusicData.shared.musicData[indexPath.row])
            NotificationCenter.default.post(Notification(name:.stopMusic))
            self.song = MusicData.shared.musicData[indexPath.row]
            self.isPlaying = true
            self.subTableView.isHidden = false
            //            self.subTableView.reloadData()
            NotificationCenter.default.post(name: .isPlaying, object: nil, userInfo: ["isPlaying": self.isPlaying])
        } else {
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
    // MARK: 플레이리스트에 저장한 노래 삭제하기
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let title = MusicData.shared.musicData[indexPath.row].title else { return }
            let alert = UIAlertController(title: "곡 삭제 확인", message: "선택한 곡 <\(title)>을(를) 삭제하시겠습니까?", preferredStyle: .alert)
            let action = UIAlertAction(title: "삭제", style: .destructive){ (action) in
                
                let target = MusicData.shared.musicData[indexPath.row]
                MusicData.shared.deleteMusicData(target)
                MusicData.shared.musicData.remove(at: indexPath.row)
                self.tableView.reloadData()
                NotificationCenter.default.post(Notification(name: .refreshNoti))
            }
            let action2 = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(action)
            alert.addAction(action2)
            present(alert, animated: true)
        }
    }
}

