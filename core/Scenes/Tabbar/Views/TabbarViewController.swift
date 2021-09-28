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
            
        UINavigationBar().isTranslucent = true
        let appearance = UITabBarAppearance.init()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = ColorPalette.tabbar
        tabBar.tintColor = ColorPalette.mistyBlue
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        tabBarItem.setTitleTextAttributes([.font: UIFont(name: AppFont.regular.name, size: 10)!], for: .normal)
    }
    
    func setupChilds() {
        guard let viewModel = viewModel as? TabbarViewModel else { return }
        let homeVC = HomeViewController.fromNib()
        homeVC.set(viewModel: viewModel.createHomeViewModel(), navigator: self.navigator)
        homeVC.tabBarItem.image = UIImage(named: "home_ic")
        homeVC.tabBarItem.title = "Home".uppercased()
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        let videoVC = VideoViewController.fromNib()
        videoVC.set(viewModel: viewModel.createVideoViewModel(), navigator: self.navigator)
        videoVC.tabBarItem.image = UIImage(named: "video_ic")
        videoVC.tabBarItem.title = "Video".uppercased()
        let videoNav = UINavigationController(rootViewController: videoVC)
        
        let profileVC = ProfileViewController.fromNib()
        profileVC.set(viewModel: viewModel.createProfileViewModel(), navigator: self.navigator)
        profileVC.tabBarItem.image = UIImage(named: "profile_ic")
        profileVC.tabBarItem.title = "Profile".uppercased()
        let profileNav = UINavigationController(rootViewController: profileVC)
        
        self.viewControllers = [homeNav, videoNav, profileNav]
    }
}
