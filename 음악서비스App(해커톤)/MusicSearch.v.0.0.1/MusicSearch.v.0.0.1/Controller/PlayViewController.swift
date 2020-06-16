//
//  PlayViewController.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/04.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var track: Track?
    var avplayer: AVPlayer?
    var timeObserver: Any?
    var a = false //drag와 endDrag 함수에서 값이 변경됨.
    
    let trackTitle = UILabel()
    let artistName = UILabel()
    let thumnail = UIImageView()
    
    let currentTimeLabel = UILabel()
    let totalDurationTimeLabel = UILabel()
    
    let playPauseButton = UIButton()
    let timeSlider = UISlider()
    let closeButton = UIButton()
    var curretnTimeValue: Double?
    //avplayer에 currentItem을 통해 재생되고있는 시간 정보(currentTime)를 가져올 수 있음. 타입은 Double.
    //밑에 prepareToPlay에서 avplayer를 정의할 때 AVPlayerItem을 사용하였기 때문에 currentItem을 사용할 수 있는 것.
    var currentTime: Double {
        return avplayer?.currentItem?.currentTime().seconds ?? 0
    }
    //avplayer에 currentItem을 통해 전체 재생 시간 정보(duration)를 가져올 수 있음. 타입은 Double.
    var totalDurationTime: Double {
        return avplayer?.currentItem?.duration.seconds ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        updateUI(track)
        prepareToPlay(track)
        timeSlider.value = 0
        //avplayer에서 CMTime을 이용해서 무엇을 할지 클로저를 통해 변수에 기능을 추가
        self.timeObserver = avplayer?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 10), queue: DispatchQueue.main){ time /*time변수의 타입은 CMTime*/in
            self.updateTime(time: time)
        }
    }
    
    @objc func dismissButton(){
        pause()
        avplayer?.replaceCurrentItem(with: nil) // CD 제거
        avplayer = nil // 전축 콘센트뽑기
        dismiss(animated: true, completion: nil)
    }
    
    func updateUI(_ x: Track?){
        guard let track = x else { return }
        let url = URL(string: track.thumbnail)!
        guard let data = try? Data(contentsOf: url),
            let img = UIImage(data: data) else { return }
        self.trackTitle.text = track.title
        self.artistName.text = track.artistName
        self.thumnail.image = img
        playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        
        trackTitle.font = UIFont.systemFont(ofSize: 25)
        artistName.font = UIFont.systemFont(ofSize: 15)
        
        thumnail.layer.cornerRadius = 20
        
        closeButton.addTarget(self, action: #selector(dismissButton), for: .touchUpInside)
        
        playPauseButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        timeSlider.addTarget(self, action: #selector(dragging), for: .touchDragInside)
        
        timeSlider.addTarget(self, action: #selector(endDragging), for: .touchDragInside)
        
        view.addSubviews([trackTitle,artistName, thumnail,currentTimeLabel,totalDurationTimeLabel, playPauseButton, timeSlider, closeButton])
        
        closeButton.layout.top(constant: 10).trailing(constant: -10)
        closeButton.setBackgroundImage(#imageLiteral(resourceName: "icClose"), for: .normal)
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        thumnail.layout.top(equalTo: closeButton.bottomAnchor, constant: 50).centerX()
        thumnail.widthAnchor.constraint(equalToConstant: 200).isActive = true
        thumnail.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        trackTitle.layout.top(equalTo: thumnail.bottomAnchor, constant: 40).centerX()
        artistName.layout.top(equalTo: trackTitle.bottomAnchor, constant: 10).centerX()
        
        timeSlider.layout.top(equalTo: artistName.bottomAnchor, constant: 50).centerX()
        timeSlider.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        timeSlider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        playPauseButton.layout.top(equalTo: timeSlider.bottomAnchor, constant: 30).centerX()
        playPauseButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        totalDurationTimeLabel.layout.top(equalTo: timeSlider.bottomAnchor, constant: 0).trailing(equalTo: timeSlider.trailingAnchor, constant: 0)
        currentTimeLabel.layout.top(equalTo: timeSlider.bottomAnchor, constant: 0).leading(equalTo: timeSlider.leadingAnchor, constant: 0)
    }
    
    //avplayer를 정의: AVplayer와 asset 활용
    func prepareToPlay(_ track: Track?){
        guard let url = track!.previewUrl else { return }
        guard let previewURL = URL(string: url) else { return }
        let player = AVPlayer(url: previewURL)
        self.avplayer = player
        avplayer?.play()
        //      self.avplayer = AVPlayer(playerItem: AVPlayerItem(asset: currentTrack.asset))
    }
    
    func updateTime(time: CMTime){
        //currentTimeLabel, totalDurationTimeLabel 값넣어주고 , slider를 재생시간에 맞춰 움직이도록 설정
        currentTimeLabel.text = secondsToString(sec: currentTime)
        totalDurationTimeLabel.text = secondsToString(sec: totalDurationTime)
        
        
        if a == false {
            timeSlider.value = Float(currentTime / totalDurationTime)
        }
    }
    
    func secondsToString(sec: Double) -> String{
        guard sec.isNaN == false else { return "00:00"}
        let totalSeconds = Int(sec)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
        //%02d:%02d : '%'는 Int로 표현하겠다는 것을 의미, 02는 숫자 두자리 00:00으로 표현하겠다는 뜻
    }
    
    func play(){
        avplayer?.play()
    }
    
    func pause(){
        avplayer?.pause()
    }
    
    func seeking(to: Double) {
        //to: 0 ~ 1의 범위를 가짐. 0.5가들어오면 전체 재생시간의 반으로 계산되는 것임.
        //전체 재생시간과 (CMTimeScale, CMTimeValue)을 통해 전체 시간이 몇 단위로 구성되는지 확인하여
        //to에 값이 들어왔을 때 그 값을 몇으로 변환하여 seek해야할지를 알려주는 것이 이 함수의 목적임.
        //여기서는, CMTimeScale이 10, CMTimeValue가 1 이므로 총 0.1초단위로 시간이 구성되기때문에 전체 재생시간에 10(CMTimeScale)만큼을 곱해서 전체구간 단위를 맞춰야 함. 예를 들어  60초의 재생시간이면 600구간이 생겨야 하는 것임.
        
        let timeScale: CMTimeScale = 10 // CMTimeScale은 Int32
        let targetTime: CMTimeValue = CMTimeValue(to * totalDurationTime) * CMTimeValue(timeScale)
        let time = CMTime(value: targetTime, timescale: timeScale)//CMTime으로 타입 변환
        avplayer?.seek(to: time)
        //위의 코드에서 to에 0.5, totalDurationTime 이 60초일 경우,
        //CMTimeScale이 10이므로 전체 구간은 600개, seeking대상은 구간 300이 됨.
        //targetTime은 0.5 * 60 * 10 = 300
        //avplayer?.seek는 CMTime을 타입으로 받기 때문에 targetTime을 CMTime으로 변환해서 넣어야함
        //CMTime = value / timescale
    }
    
    @objc func playButtonTapped(_ sender: UIButton) {
        let isPlay = avplayer?.rate == 1 //rate 가 1이면 재생, 0이면 정지를 의미
        if isPlay {
            pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        } else {
            play()
            playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
    }
    
    @objc func dragging(_ sender:  UISlider){
        a = true
    }
    
    @objc func endDragging(_ sender: UISlider){
        a = false
        seeking(to: Double(sender.value))
    }
}

