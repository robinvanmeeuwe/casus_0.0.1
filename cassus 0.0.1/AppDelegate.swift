//
//  AppDelegate.swift
//  casus 0.0.1
//
//  Created by Robin van Meeuwen on 22/10/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0, green: 0.506, blue: 0.914, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor(red: 0, green: 0.506, blue: 0.914, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 24)!]
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "back_icon")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "back_icon")
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red, NSAttributedString.Key.font: UIFont(name:"Roboto-Bold", size: 16)!], for: UIControl.State.normal)
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor(red: 0, green: 0.506, blue: 0.914, alpha: 1)
            appearance.shadowColor = .clear
            
            let navigationBar = UINavigationBar()
            navigationBar.standardAppearance = appearance
            
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

