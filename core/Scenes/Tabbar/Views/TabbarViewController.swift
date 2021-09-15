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
        let homeVC = HomeViewController.fromNib(ofType: HomeViewController.self)
        homeVC.set(viewModel: viewModel.createHomeViewModel(), navigator: self.navigator)
        homeVC.tabBarItem.image = UIImage(named: "home_ic")
        homeVC.tabBarItem.title = "Home".uppercased()
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        let videoVC = VideoViewController.fromNib(ofType: VideoViewController.self)
        videoVC.set(viewModel: viewModel.createVideoViewModel(), navigator: self.navigator)
        videoVC.tabBarItem.image = UIImage(named: "video_ic")
        videoVC.tabBarItem.title = "Video".uppercased()
        let videoNav = UINavigationController(rootViewController: videoVC)
        
        let profileVC = ProfileViewController.fromNib(ofType: ProfileViewController.self)
        profileVC.set(viewModel: viewModel.createProfileViewModel(), navigator: self.navigator)
        profileVC.tabBarItem.image = UIImage(named: "profile_ic")
        profileVC.tabBarItem.title = "Profile".uppercased()
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        self.viewControllers = [homeNav, videoNav, profileNav]
    }
}
