//
//  PlayViewController.swift
//  myMusic2
//
//  Created by 신용철 on 2019/12/12.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    //    -segue 연결
    //    -segue 데이터 받기
    //    -받은 데이터 정보 표기
    //    -플레이어 준비
    //    -시간 업데이트기능
    //    -currentTime
    //    -totalDuration
    //    -플레이 함수
    //    -정지 함수
    //    -seeking
    //    -플레이 버튼 탭
    //    -슬라이더 벨류 변경
    //    -드레깅 엔드
    //    -닫기
    
    
    var track: Track?
    var avplayer: AVPlayer?
    var timeObserver: Any?
    var a = false //drag와 endDrag 함수에서 값이 변경됨.
    
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var thumnail: UIImageView!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalDurationTimeLabel: UILabel!
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    
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
        updateUI(track)
        prepareToPlay(track)
        timeSlider.value = 0
        currentTimeLabel.text = secondsToString(sec: currentTime)
        totalDurationTimeLabel.text = secondsToString(sec: totalDurationTime)
        //avplayer에서 CMTime을 이용해서 무엇을 할지 클로저를 통해 변수에 기능을 추가
        self.timeObserver = avplayer?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 10), queue: DispatchQueue.main){ time /*time변수의 타입은 CMTime*/in
            self.updateTime(time: time)
        }
    }
    
    func updateUI(_ x: Track?){
        guard let track = x else { return }
        self.trackTitle.text = track.title
        self.artistName.text = track.artist
        self.thumnail.image = track.thumb
        playPauseButton.setImage(#imageLiteral(resourceName: "icPlay"), for: .normal)
    }
    
    //avplayer를 정의: AVplayer와 asset 활용
    func prepareToPlay(_ x: Track?){
        guard let currentTrack = x else {return}
        let asset = currentTrack.asset
        let playerItem = AVPlayerItem(asset: asset) //AV
        let player = AVPlayer(playerItem: playerItem)
        self.avplayer = player
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
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        let isPlay = avplayer?.rate == 1 //rate 가 1이면 재생, 0이면 정지를 의미
        if isPlay {
            pause()
            playPauseButton.setImage(#imageLiteral(resourceName: "icPlay"), for: .normal)
        } else {
            play()
            playPauseButton.setImage(#imageLiteral(resourceName: "icPause"), for: .normal)
        }
    }
    
    
    
    @IBAction func dragging(_ sender:  UISlider){
        a = true
        print("dragging")
    }
    
    @IBAction func endDragging(_ sender: UISlider){
        a = false
        print("endDragging")
        seeking(to: Double(sender.value))
    }
    
    @IBAction func close(_ sender: UIButton){
        pause()
        avplayer?.replaceCurrentItem(with: nil) // CD 제거
        avplayer = nil // 전축 콘센트뽑기
        dismiss(animated: true, completion: nil)
    }
}

