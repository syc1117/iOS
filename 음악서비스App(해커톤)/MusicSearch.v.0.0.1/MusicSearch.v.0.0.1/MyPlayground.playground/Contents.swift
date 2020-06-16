//import UIKit
//
//struct PlayList {
//    let playListTitle: String
//    let plaList: [String: String]
//}
//
//class MusicCoreData {
//    let title: String
//    let artistName: String
//    let thumbnail: String
//    let previewUrl: String?
//
//    var toDictionary: [String: String] {
//        ["title": title, "artistName": artistName,  "artworkUrl30": thumbnail, "previewUrl": previewUrl ]
//    }
//}
//[Track]
//func addCoreData(playListTitle: String, plaList: Track?)
//PlayList.playListTitle = playListTitle
//PlayList.plaList = plaList.toDictionary
//saveContext()
//
//"1번 좋아요리스트" : "지코의 아무노래",
//
//"1번 좋아요리스트" : "아이유의 좋은날",
//
//"2번 좋아요리스트" : "레드벨벳의 빨간맛",
//
//"2번 좋아요리스트" : "레드벨벳의 사이코"
//
//PlayList["1번 좋아요리스트"] = []
//
//PlayList.keys.sorted() = ["1번 좋아요리스트", "1번 좋아요리스트", "2번 좋아요리스트", "2번 좋아요리스트"] => 중복제거 => list
//
//let key = list[index.item]
//
//let imgList = PlayList[key].map{ $0.thumbnail }.forEach{ $0 }
//
