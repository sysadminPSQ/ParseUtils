//
//  AppDelegate.swift
//  ParseUtils
//
//  Created by Akash K on 15/09/15.
//  Copyright (c) 2015 pepper square. All rights reserved.
//

import UIKit
import Parse
import Bolts
import LogKit
import ParseCrashReporting

let log = LXLogger(endpoints: [
    
    LXLogSerialConsoleEndpoint(
        dateFormatter: {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH':'mm':'ss'.'SSS"
            dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            return dateFormatter
            }(),
        entryFormatter: { entry in
            return "\(entry.dateTime) [\(entry.logLevel.uppercaseString)] \(entry.message)"
        }
    ),
    
    LXLogFileEndpoint(
        fileURL: (NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as? [NSURL])?.first?
            .URLByAppendingPathComponent("logs", isDirectory: true)
            .URLByAppendingPathComponent("log.txt"),
        minimumLogLevel: .Notice,
        entryFormatter: { entry in
            return "\(entry.dateTime) (\(entry.timestamp)) [\(entry.logLevel.uppercaseString)] {thread: \(entry.threadID) '\(entry.threadName)' main: \(entry.isMainThread)} \(entry.functionName) <\(entry.fileName):\(entry.lineNumber).\(entry.columnNumber)> \(entry.message)"
        }
    ),
    
    ])

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        ParseCrashReporting.enable()
        
        // Initialize Parse.
        Parse.setApplicationId("DenJS8MkQnuT6D6EyxXehflWuidthuSnic64XaHO",
            clientKey: "ivydkvmt3QqknStODRWaHf2H5QcwNKWCa8qTV0hh")
        
        // PFUser.enableRevocableSessionInBackground()
//        Parse.enableLocalDatastore()
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        // Overtiding the status bar default style to reflect in the entire application
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
        // Navigation bar style changed using custom hex values for background color
        var navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = uicolorFromHex(0xffffff)
        navigationBarAppearace.barTintColor = uicolorFromHex(0xef5265)
        
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        // Navigation bar style changed using custom hex values for background color
        UITabBar.appearance().tintColor = uicolorFromHex(0xffffff)
        UITabBar.appearance().barTintColor = uicolorFromHex(0xef5265)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        
        return true
    }
    
    // custom function to choose color of your choice from hex values
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
}

