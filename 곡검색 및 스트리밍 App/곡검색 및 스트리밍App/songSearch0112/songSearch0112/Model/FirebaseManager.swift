//
//  FirebaseManager.swift
//  songSearch0112
//
//  Created by 신용철 on 2020/01/12.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import Firebase

class FirebaseManager {
    static let shared = FirebaseManager()
    
    let rootRef = Database.database().reference()
    
    var searchHistory: [String] = []
    var wathchHistory: [Track] = []
    
    //서버에 데이터 저장
    func saveSearchHistroy(_ searchText: String){
        self.searchHistory.insert(searchText, at: 0)
        rootRef.child("search").setValue(searchHistory)
    }
    
    func saveWatchHistory(_ track: Track){
        //Track -> [Dict]
        self.wathchHistory.insert(track, at: 0)
        let dict = wathchHistory.map{$0.toDictionary}
        rootRef.child("watch").setValue(dict)
    }
    
    //서버에서 데이터 가져오기
    func fetchSearchHistory(_ completion: @escaping () -> Void) {
        rootRef.child("search").queryLimited(toFirst: 3).observeSingleEvent(of: .value) { snapshot in
            guard let searchData = snapshot.value as? [String] else { return }
            self.searchHistory = searchData
            completion()
        }
    }
    
    func fetchWatchHistory(_ completion: @escaping() -> Void){
        rootRef.child("watch").queryLimited(toFirst: 3).observeSingleEvent(of: .value) { snapshot in
            //dict -> [Track]
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshot.value, options: [])
                let trackData = try JSONDecoder().decode([Track].self, from: data)
                self.wathchHistory = trackData
                completion()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}


struct Response: Codable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Codable {
    let title: String
    let artistName: String
    let thumbnail: String
    let previewUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case artistName = "artistName"
        case thumbnail = "artworkUrl30"
        case previewUrl = "previewUrl"
    }
    
    var toDictionary: [String: Any] {
        return ["trackName":title, "artistName": artistName, "artworkUrl30": thumbnail,"previewUrl": previewUrl]
    }
}
