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
import CZPicker

var existingRF: [PFObject] = []
var existingRT: [PFObject] = []
var existingBuildings: [PFObject] = []
var floorObjects: [PFObject] = []
var RF: [PFObject] = []

class ViewController: UIViewController, CZPickerViewDelegate, CZPickerViewDataSource {

    @IBOutlet var addRoomFacilitiesTF: UITextField!
    @IBOutlet var roomFacilitiesCV: UICollectionView!
    
    @IBOutlet var roomTypesTF: UITextField!
    @IBOutlet var rtDescription: UITextField!
    
    @IBOutlet var buildingTF: UITextField!
    @IBOutlet var totalFloorsTF: UITextField!
    
    var roomTypeNames: [String] = []
    
    let collectionHelper = CollectionHelper()
    let pb = ParseBinder()
    let rt = RoomType()
    let building = Building()
    var floor = Floor()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadRoomFacilities()
        loadRoomTypes()
        loadBuildings()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Save room facilities
    @IBAction func saveRoomFacilities(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        let rf = RoomFacility()
        rf.name = addRoomFacilitiesTF.text!
        
        pb.saveObj(rf,
            succFn: {
                () in
                print("Success")
                self.addRoomFacilitiesTF.text = ""
                self.loadRoomFacilities()
            },
            failFn: {
                (error: NSError) in
                print("RF - \(error.userInfo)")
        })
    }
    
    //MARK: Save Room Types
    @IBAction func saveRoomTypes(sender: AnyObject) {
        
        
        rt.name = roomTypesTF.text!
        rt["description"] = rtDescription.text
        rt.roomFacilities = existingRF
        
        pb.saveObj(rt,
            succFn: {
                () in
                print("Success")
                self.roomTypesTF.text = ""
                self.rtDescription.text = ""
            },
            failFn: {
                (error: NSError) in
                print("RF - \(error.userInfo)")
        })
    }
    
    //MARK: Save Building
    @IBAction func saveBuilding(sender: AnyObject) {
        
        building.name = buildingTF.text!
        building.totalFloors = Int(totalFloorsTF.text!)!
        building.roomTypes = existingRT
        
        pb.saveObj(building,
            succFn: {
                () in
                print("Success")
                
                self.saveFloors()
            },
            failFn: {
                (error: NSError) in
                print("RF - \(error.userInfo)")
        })
        
    }
    
    //MARK: Save floors
    func saveFloors() {
        
        for (var i = 0; i <= Int(totalFloorsTF.text!); i++) {
            print("entered")
            let floor = PFObject(className: "Floor")
            floor["floorNumber"] = i as Int
            floor["building"] = building as PFObject
            floorObjects.insert(floor, atIndex: i)
            print("the floor objects are: \(floorObjects)")
        }
        buildingTF.text = ""
        totalFloorsTF.text = ""
        PFObject.saveAllInBackground(floorObjects)
        
    }
    
    @IBAction func pickRoomType(sender: AnyObject) {
        
        let picker = CZPickerView(headerTitle: "Room Types", cancelButtonTitle: "Cancel", confirmButtonTitle: "Confirm")
        picker.delegate = self
        picker.dataSource = self
        picker.needFooterView = false
        picker.show()
    }
    
    func numberOfRowsInPickerView(pickerView: CZPickerView!) -> Int {
        return roomTypeNames.count
    }
    
    func czpickerView(pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        
        return "\(roomTypeNames[row])"
    }
    
    func czpickerView(pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int){
        
        buildingTF.text = roomTypeNames[row] as String
    }
    
    //MARK: Load room facilities
    func loadRoomFacilities() {
        
        let query = PFQuery(className: "RoomFacility")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let object = objects {
                    
                        existingRF = Array(object.generate())
                }
                
                self.roomFacilitiesCV.reloadData()
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    //MARK: Load room types
    func loadRoomTypes() {
        
        let query = PFQuery(className: "RoomType")
        //query.whereKey("name", equalTo: "Queen")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let object = objects {
                    
                    existingRT = Array(object.generate())
                    
                    for items in existingRT {
                        
                        self.roomTypeNames.append(items["name"] as! String)
                    }
                    
                    for roomTypes in object {
                        
                        for roomfacilities in [roomTypes] {
                            
                            for object in roomfacilities["roomFacilities"] as! [PFObject] {
                                
                                let r = object["name"]
                                print("\(r)")
                            }
                        }
                    }
                }
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    //MARK: Load exisitng Buidings
    func loadBuildings() {
        
        let query = Building.query()
        
        query!.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let object = objects {
                    
                    for buildings in object {
                        
                        existingBuildings.append(buildings)
                    }
                }
                
                //println("The existing buildings are: \(existingBuildings)")
                
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // to make sure the keyboard gets hidden once you touch outside the text box.
        self.view.endEditing(true)
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
