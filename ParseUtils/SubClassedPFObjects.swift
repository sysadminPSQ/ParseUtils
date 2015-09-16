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
    
    class func parseClassName() -> String {
        return "RoomType"
    }
    
    @NSManaged var name: String
    @NSManaged var roomFacilities: [PFObject]?
    @NSManaged var roomSize: String
    @NSManaged var entityID: PFObject!
    @NSManaged var createdBy: PFUser!
    @NSManaged var Description: String
    
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

class Building : SubClassedPFObjects, PFSubclassing {
    
    override class func initialize() {
        registerSubclass()
    }
    
    class func parseClassName() -> String {
        return "Building"
    }
    
    @NSManaged var name: String
    @NSManaged var totalFloors: Int
    @NSManaged var roomTypes: [PFObject]
    @NSManaged var entityID: PFObject!
    @NSManaged var createdBy: PFUser!
    
}
class Floor : SubClassedPFObjects, PFSubclassing {
    
    override class func initialize() {
        registerSubclass()
    }
    
    class func parseClassName() -> String {
        return "Floor"
    }
    
    @NSManaged var name: String
    @NSManaged var floorNumber: Int
    @NSManaged var building: PFObject
    @NSManaged var entityID: PFObject!
    @NSManaged var createdBy: PFUser!
    
}


