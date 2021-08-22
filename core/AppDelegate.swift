//
//  AppDelegate.swift
//  core
//
//  Created by phuong.doan on 6/30/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Application.shared.presentInitialScreen(in: window)
        return true
    }
}

