//
//  TabbarViewController.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import UIKit

class TabbarViewController: UITabBarController {

    var viewModel: ViewModel?
    var navigator: Navigator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
    }
    
    func setupChilds() {
        guard let viewModel = viewModel as? TabbarViewModel else { return }
        guard let homeVC = HomeViewController.fromNib(ofType: HomeViewController.self, viewModel: viewModel.createHomeViewModel(), navigator: self.navigator) else { return }
        homeVC.tabBarItem.image = UIImage(named: "home_ic")
        homeVC.tabBarItem.title = "Home"
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        guard let videoVC = VideoViewController.fromNib(ofType: VideoViewController.self, viewModel: viewModel.createHomeViewModel(), navigator: self.navigator) else { return }
        videoVC.tabBarItem.image = UIImage(named: "home_ic")
        videoVC.tabBarItem.title = "Video"
        let videoNav = UINavigationController(rootViewController: videoVC)
        
        guard let profileVC = ProfileViewController.fromNib(ofType: ProfileViewController.self, viewModel: viewModel.createProfileViewModel(), navigator: self.navigator) else { return }
        profileVC.tabBarItem.image = UIImage(named: "home_ic")
        profileVC.tabBarItem.title = "Profile"
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        self.viewControllers = [homeNav, videoNav, profileNav]
    }
}
