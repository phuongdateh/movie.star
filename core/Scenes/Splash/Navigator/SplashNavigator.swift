//
//  SplashNavigator.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit

protocol SplashNavigatorProtocol: AnyObject {
    
}

class SplashNavigator: SplashNavigatorProtocol {
    private let navigationController: UINavigationController
    private let services: NetworkUseCaseProvider
    private let storyboard: UIStoryboard
    
    init(_ storyboard: UIStoryboard,
         _ navigationController: UINavigationController,
         _ services: NetworkUseCaseProvider) {
        self.storyboard = storyboard
        self.navigationController = navigationController
        self.services = services
    }
    
    func start() {
        // start viewController
        let vc = storyboard.instantiateViewController(ofType: SplashViewController.self)
        navigationController.pushViewController(vc, animated: true)
    }
}
