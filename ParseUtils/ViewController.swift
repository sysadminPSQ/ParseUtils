//
//  ViewController.swift
//  ParseUtils
//
//  Created by Akash K on 15/09/15.
//  Copyright (c) 2015 pepper square. All rights reserved.
//

import UIKit
import Parse
import Bolts
import SwiftUtils

var existingRF = [PFObject]()

class ViewController: UIViewController {

    @IBOutlet var addRoomFacilitiesTF: UITextField!
    @IBOutlet var roomFacilitiesCV: UICollectionView!
    let collectionHelper = CollectionHelper()
    let pb = ParseBinder()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadRoomFacilities()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveRoomFacilities(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        let rf = RoomFacility()
        rf.name = "Room Service"
        
        pb.saveObj(rf,
            succFn: {
                () in
                println("Success")
            },
            failFn: {
                (error: NSError) in
                log.warning("RF - \(error.userInfo)")
        })
    }
    
    func loadRoomFacilities() {
        
        var query = PFQuery(className: "RoomFacility")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects as? [PFObject] {
                    
                    for object in objects {
                        
                        existingRF.append(object)
                    }
                }
                
                self.roomFacilitiesCV.reloadData()
                
            } else {
                // Log details of the failure
                log.warning("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return existingRF.count
    }
    
    //MARK: Multiple collection views in one control - Refer CollectionHelper.swift
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return collectionHelper.RoomFacilities(collectionView, indexPath: indexPath)
    }
    
}
