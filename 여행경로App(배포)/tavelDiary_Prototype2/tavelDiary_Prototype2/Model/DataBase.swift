//
//  DataBase.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/02/24.
//  Copyright © 2020 신용철. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class DataBase {

    static let shared = DataBase()
    
 
  
    //메모리 올라갈 때 바로 만들어짐
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    } //접근할 때 비로소 리턴 실행
    
    
    var data = [Data]()
    
    func fetchData(completion: @escaping () -> ()) {
        defer {
            completion()
        }
        let request:NSFetchRequest<Data> = Data.fetchRequest()
        
        do {
            data = try mainContext.fetch(request)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addCoreData(tripTitle: String, startingDate: String,endDate: String, distance: Double, navigationLabel: String,  titleArray: [String], longitude: [CLLocationDegrees], latitude: [CLLocationDegrees], memo: String ){
        let newArray = Data(context: mainContext)
        newArray.latitude = latitude
        newArray.longitude = longitude
        newArray.distance = distance
        newArray.navigationLabel = navigationLabel
        newArray.titleArray = titleArray
        newArray.tripTitle = tripTitle
        newArray.startingDate = startingDate
        newArray.endDate = endDate
        newArray.memo = memo
        
        saveContext()
    }
    
    func deleteData (_ data: Data?) {
            if let data = data { mainContext.delete(data)
            saveContext()
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "tavelDiary_Prototype2")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
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
