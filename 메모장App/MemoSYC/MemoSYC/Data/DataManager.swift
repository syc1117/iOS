//
//  DataManager.swift
//  MemoSYC
//
//  Created by 신용철 on 2020/06/15.
//  Copyright © 2020 신용철. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    private init () {
        
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var memoList: [Memo] = []
    
    func fetchMemo () {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        //coreData에서 가져오는 정보들은 기본적으로 정렬이 되어 있지 않기 때문에 별도의 정렬 방식을 설정해주어야 함.
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
           memoList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func addNewMemo (_ memo: String) {
        let newMemo = Memo(context: mainContext)
        newMemo.content = memo
        newMemo.insertDate = Date()
        memoList.insert(newMemo, at: 0)
        saveContext()
    }
    
    func deleteMemo (_ memo: Memo? ) {
        if let memo = memo {
            mainContext.delete(memo)
            saveContext()
        }
    }
    
    // MARK: - Core Data stack

       lazy var persistentContainer: NSPersistentContainer = {
          
           let container = NSPersistentContainer(name: "MemoSYC")
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
