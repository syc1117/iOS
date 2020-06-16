//
//  Track.swift
//  myMusic2
//
//  Created by 신용철 on 2019/12/12.
//  Copyright © 2019 신용철. All rights reserved.
//

import UIKit
import AVFoundation

class Track {

    var title: String
    var thumb: UIImage
    var artist: String
    
    
    init (title: String, thumb: UIImage, artist: String){
        self.title = title
        self.thumb = thumb
        self.artist = artist
        
    }
    
    
    var asset: AVAsset {
        let path = Bundle.main.path(forResource: title, ofType: "mov")!
        let url = URL(fileURLWithPath: path)
        let asset = AVAsset(url: url)
        return asset
    }
    
}


