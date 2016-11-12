//
//  AppDelegate.swift
//  Resepi
//
//  Created by Harpreet Singh on 11/8/16.
//  Copyright © 2016 Harpreet Singh. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        // Initialize Parse
        UserClient.initializeParse()
        
        if PFUser.current() != nil {
            print("There is a current user")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let recipesNavigationController = storyboard.instantiateViewController(withIdentifier: "RecipesNavigationController") as! UINavigationController
            recipesNavigationController.tabBarItem.title = "Recipes"
            recipesNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Home Icon")
            
            
            let dataNavigationController = storyboard.instantiateViewController(withIdentifier: "DataNavigationController") as! UINavigationController
            dataNavigationController.tabBarItem.title = "Data"
            dataNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Data Icon")
            
            let userProfileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
            userProfileNavigationController.tabBarItem.title = "Profile"
            userProfileNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Profile Icon")
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [recipesNavigationController, dataNavigationController, userProfileNavigationController]
            self.window?.rootViewController = tabBarController
            
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Log In User"), object: nil, queue: OperationQueue.main) { (NSNotification) -> Void in
            
            print("you are logged in")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let recipesNavigationController = storyboard.instantiateViewController(withIdentifier: "RecipesNavigationController") as! UINavigationController
            recipesNavigationController.tabBarItem.title = "Recipes"
            recipesNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Home Icon")
            
            
            let dataNavigationController = storyboard.instantiateViewController(withIdentifier: "DataNavigationController") as! UINavigationController
            dataNavigationController.tabBarItem.title = "Data"
            dataNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Data Icon")
            
            let userProfileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
            userProfileNavigationController.tabBarItem.title = "Profile"
            userProfileNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Profile Icon")
            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [recipesNavigationController, dataNavigationController, userProfileNavigationController]
            self.window?.rootViewController = tabBarController
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Log Out User"), object: nil, queue: OperationQueue.main) { (NSNotification) -> Void in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            self.window?.rootViewController = vc
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

