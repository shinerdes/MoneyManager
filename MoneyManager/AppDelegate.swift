//
//  AppDelegate.swift
//  MoneyManager
//
//  Created by 김영석 on 2018. 10. 15..
//  Copyright © 2018년 김영석. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        ///Users/remind/Library/Developer/CoreSimulator/Devices/964095AC-CB1C-4842-A7D9-9AEC1D82EE57/data/Containers/Data/Application/60908CFF-0F29-446A-A1D1-45E29110D2BC/Documents/
        
        
//                let defaultPath = Realm.Configuration.defaultConfiguration.fileURL?.path
//                let path = Bundle.main.path(forResource: "default", ofType: "realm")
//
//                if let defaultPath = defaultPath, let bundledPath = path {
//                    do {
//                        try FileManager.default.copyItem(atPath: bundledPath, toPath: defaultPath)
//                    } catch {
//                        print("Error copying pre-populated Realm \(error)")
//                    }
//                }// realm 설치
//
        
        do
        {
            _ = try Realm()
            
        } catch {
            print("Error initalising new realm, \(error)")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
