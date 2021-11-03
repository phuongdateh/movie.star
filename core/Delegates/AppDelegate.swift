//
//  AppDelegate.swift
//  core
//
//  Created by phuong.doan on 6/30/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.setupThirdParty()
        Application.shared.presentInitialScreen(in: window)
        return true
    }
}

extension AppDelegate {
    private func setupThirdParty() {
        IQKeyboardManager.shared.enable = true
    }
}
