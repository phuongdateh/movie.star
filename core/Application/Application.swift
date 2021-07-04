//
//  Application.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: NetworkUseCaseProvider
    
    init() {
        self.networkUseCaseProvider = NetworkUseCaseProvider()
    }
    
    func config(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Splash", bundle: nil)
        let navigationController = UINavigationController()
        let splashNavigator = SplashNavigator(storyboard,
                                              navigationController,
                                              networkUseCaseProvider)
        window.rootViewController = navigationController
        splashNavigator.start()
    }
}
