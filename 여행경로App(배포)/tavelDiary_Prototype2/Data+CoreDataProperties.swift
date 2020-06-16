//
//  Data+CoreDataProperties.swift
//  tavelDiary_Prototype2
//
//  Created by 신용철 on 2020/03/10.
//  Copyright © 2020 신용철. All rights reserved.
//
//

import Foundation
import CoreData
import MapKit

extension Data {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Data> {
        return NSFetchRequest<Data>(entityName: "Data")
    }
    @NSManaged public var latitude: [CLLocationDegrees]
    @NSManaged public var longitude: [CLLocationDegrees]
    @NSManaged public var distance: Double
    @NSManaged public var navigationLabel: String
    @NSManaged public var titleArray: [String]
    @NSManaged public var tripTitle: String
    @NSManaged public var startingDate: String
    @NSManaged public var endDate: String
    @NSManaged public var memo: String
}
