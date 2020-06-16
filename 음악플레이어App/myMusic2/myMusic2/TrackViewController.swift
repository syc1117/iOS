//
//  ViewController.swift
//  myMusic2
//
//  Created by 신용철 on 2019/12/12.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {
    
    var musicList: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSet()
    }
    
    func uiSet(){
        musicList = [
            Track(title: "Swish", thumb: #imageLiteral(resourceName: "Swish"),artist: "Tyga"),
            Track(title: "Dip", thumb: #imageLiteral(resourceName: "Dip"), artist: "Tyga"),
            Track(title: "The Harlem Barber Swing", thumb: #imageLiteral(resourceName: "The Harlem Barber Swing"), artist: "Jazzinuf"),
            Track(title: "Believer", thumb: #imageLiteral(resourceName: "Believer"), artist: "Imagine Dragon"),
            Track(title: "Blue Birds", thumb: #imageLiteral(resourceName: "Blue Birds"), artist: "Eevee"),
            Track(title: "Best Mistake", thumb: #imageLiteral(resourceName: "Best Mistake"), artist: "Ariana Grande"),
            Track(title: "thank u, next", thumb: #imageLiteral(resourceName: "thank u, next"), artist: "Ariana Grande"),
            Track(title: "7 rings", thumb: #imageLiteral(resourceName: "7 rings"), artist: "Ariana Grande")
        ]
    }
}

extension TrackViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlay", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let playVC = segue.destination as? PlayViewController else { return }
        if let index = sender as? Int {
            playVC.track = musicList[index]
        }
    }
}

extension TrackViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as? TrackCell else { return UITableViewCell() }
        cell.setting(musicList[indexPath.row])
        return cell
    }
}

class TrackCell: UITableViewCell{
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var artist: UILabel!
    
    func setting(_ x: Track){
        self.thumbnail.image = x.thumb
        self.title.text = x.title
        self.artist.text = x.artist
    }
}
