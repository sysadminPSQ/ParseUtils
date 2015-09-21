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
    
    var test: [PFObject]!
    
    init() {
        
    }
    
    func RoomFacilities(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("roomFacilities", forIndexPath: indexPath) as! RoomFacilitiesCell
        
        cell.roomFacilitiesLbl.text = existingRF[indexPath.row]["name"] as? String
        
        return cell
    }
    
}