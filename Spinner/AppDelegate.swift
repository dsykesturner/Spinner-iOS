//
//  AppDelegate.swift
//  Spinner
//
//  Created by Daniel Sykes-Turner on 10/09/2016.
//  Copyright © 2016 UniverseApps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let musicList = ["Justin Bieber","Skip-hop","Summer Tunez","Geelong Theme Song","90s Dance Party","Drunk Sing-a-longs","Cher","Britney","Abba","Audiobooks","Splendour Mems","Hilary Duff","90s Pop","Ke$ha","Funfunfun"]
    let moneyList = ["$20","$100","$40","$200","$60","$0.01","$10,000","$10","$90","$30","$70","$50","$80"]
    
    var spinnerLists: [[String:[String]]]! {
        get {
            if let l = UserDefaults.standard.array(forKey: "spinnerLists") as? [[String:[String]]] {
                return l
            } else {
                return [["The Original Wheel":musicList], ["Cash":moneyList]]
            }
        }
        set(newLists) {
            UserDefaults.standard.set(newLists, forKey: "spinnerLists")
        }
    }
    var selectedSpinnerIndex: Int! {
        get {
            let index = UserDefaults.standard.integer(forKey: "spinnerIndex")
            if index > self.spinnerLists.count-1 {
                return 0
            } else {
                return index
            }
        }
        set(newIndex) {
            UserDefaults.standard.set(newIndex, forKey: "spinnerIndex")
        }
    }
    var radius: Int! {
        get {
            let r = UserDefaults.standard.integer(forKey: "radius")
            if r <= 0 {
                return Int((self.window?.frame.size.height)!/2)
            } else {
                return r
            }
        }
        set(newRadius) {
            UserDefaults.standard.set(newRadius, forKey: "radius")
        }
    }
    var friction: Double! {
        get {
            let d = UserDefaults.standard.double(forKey: "double")
            if d <= 0.0 {
                return 0.992
            } else {
                return d
            }
        }
        set(newFriction) {
            UserDefaults.standard.set(newFriction, forKey: "double")
        }
    }
    var sections: Int! {
        // Note: Only applicable for the numbers set
        get {
            let s = UserDefaults.standard.integer(forKey: "sections")
            if s <= 0 {
                return 20
            } else {
                return s
            }
        }
        set(newSections) {
            UserDefaults.standard.set(newSections, forKey: "sections")
        }
    }
    var textSize: Int! {
        get {
            let s = UserDefaults.standard.integer(forKey: "textSize")
            if s <= 0 {
                return 24
            } else {
                return s
            }
        }
        set(newSize) {
            UserDefaults.standard.set(newSize, forKey: "textSize")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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

func appDelegate() -> AppDelegate!
{
    return UIApplication.shared.delegate as! AppDelegate
}
