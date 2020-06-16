//
//  Track.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/03.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import AVFoundation


    struct Response: Codable {
        let resultCount: Int
        let results: [Track]
    }

    struct Track: Codable {
        let title: String
        let artistName: String
        let thumbnail: String
        let previewUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case title = "trackName"
            case artistName = "artistName"
            case thumbnail = "artworkUrl100"
            case previewUrl = "previewUrl"
        }
       
        var toDictionary: [String: Any] {
            ["title": title, "artistName": artistName,  "artworkUrl00": thumbnail, "previewUrl": previewUrl ]
        }
    }



// MARK: asset파일에 있는 음악
class Track2 {
    var title: String
    var thumb: UIImage
    var artist: String
    
    init (title: String, thumb: UIImage, artist: String){
        self.title = title
        self.thumb = thumb
        self.artist = artist
    }
    
    var asset: AVAsset {
        let path = Bundle.main.path(forResource: title, ofType: "mp3") ?? Bundle.main.path(forResource: title, ofType: "mov")
        let url = URL(fileURLWithPath: path!)
        let asset = AVAsset(url: url)
        return asset
        
    }
}
