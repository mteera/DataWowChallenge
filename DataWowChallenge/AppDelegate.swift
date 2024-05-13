//
//  AppDelegate.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 13/5/2567 BE.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = ListViewController(nibName: "\(ListViewController.self)", bundle: nil)
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

