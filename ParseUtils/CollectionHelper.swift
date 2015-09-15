//
//  CollectionHelper.swift
//  Swift-CollectionView
//
//  Created by Akash on 25/08/15.
//  Copyright (c) 2015 Akash. All rights reserved.
//

import Foundation
import UIKit
import Parse
import Bolts

class CollectionHelper {
    
    func RoomFacilities(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("roomFacilities", forIndexPath: indexPath) as! RoomFacilitiesCell
    
        println("The value in exsting object is : \(existingRF)")
        
        for object in existingRF as [PFObject] {
            
            cell.roomFacilitiesLbl.text = object["name"] as! String
            //cell.roomFacilitiesLbl.text = object[indexPath.row]
        }
        
        return cell
    }
    
}