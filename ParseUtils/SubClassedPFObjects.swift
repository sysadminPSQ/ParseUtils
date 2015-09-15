//
//  SubClassedPFObjects.swift
//  RoomAdvantage
//
//  Created by Akash on 02/09/15.
//  Copyright (c) 2015 pepper square. All rights reserved.
//

import Foundation
import Parse
import Bolts
import UIKit
import SwiftUtils

class RoomType : SubClassedPFObjects, PFSubclassing {
    
    override class func initialize() {
        registerSubclass()
    }
    
    override func addValue(key: String, value: Any) {
        if key == "roomTypes" {
            roomTypes.append(value as! String)
        }
    }
    
    class func parseClassName() -> String {
        return "RoomType"
    }
    
    override func hasErrors() -> Bool {
        return buildingName.isEmpty || totalFloors <= 0 || roomTypes.count == 0
    }
    
    @NSManaged var buildingName: String
    @NSManaged var totalFloors: Int
    @NSManaged var roomTypes: [String]
    @NSManaged var entityID: PFObject!
    @NSManaged var createdBy: PFUser!
    
}

class RoomFacility : SubClassedPFObjects, PFSubclassing {
    
    override class func initialize() {
        registerSubclass()
    }
    
    class func parseClassName() -> String {
        return "RoomFacility"
    }
    
    @NSManaged var name: String
    @NSManaged var entityID: PFObject!
    @NSManaged var createdBy: PFUser!
    
}


