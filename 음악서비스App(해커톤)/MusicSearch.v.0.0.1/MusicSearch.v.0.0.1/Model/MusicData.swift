//
//  CoreData.swift
//  MusicSearch.v.0.0.1
//
//  Created by 신용철 on 2020/02/03.
//  Copyright © 2020 신용철. All rights reserved.
//
import UIKit
import Foundation
import CoreData

extension Notification.Name {
    static let refreshNoti = Notification.Name("refreshNoti")
}

class MusicData {
    
    static let shared = MusicData()
    
    var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var musicData:[MusicCoreData] = []
    
    // MARK: 값 불러오기
    func fetchMusicData(){
        let request: NSFetchRequest<MusicCoreData> = MusicCoreData.fetchRequest()
        do{
            musicData = try mainContext.fetch(request)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: 값 저장하기
    
    func addMusicData(title: String = "", artistName: String = "", thumbnail: String = "", previewUrl: String = ""  ){
        let array = musicData.map{$0.previewUrl}
        if !array.contains(previewUrl) {
            let newMusicData = MusicCoreData(context: self.mainContext)
            newMusicData.title = title
            newMusicData.artistName = artistName
            newMusicData.thumbnail = thumbnail
            newMusicData.previewUrl = previewUrl
            self.musicData.insert(newMusicData, at: 0)
            self.saveContext()
            NotificationCenter.default.post(Notification(name: .refreshNoti))
            NotificationCenter.default.post(Notification(name:.showCollectionView))
        } else {
            return
        }
    }
    
    // MARK: 값 삭제하기
    func deleteMusicData(_ musicData: MusicCoreData){
        mainContext.delete(musicData)
        saveContext()
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MusicSearch_v_0_0_1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
