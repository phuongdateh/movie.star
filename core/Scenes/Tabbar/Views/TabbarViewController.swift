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
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance.init()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = ColorPalette.strongBlue
            tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
        } else {
            UITabBar.appearance().backgroundColor = ColorPalette.strongBlue
            UITabBar.appearance().tintColor = ColorPalette.orange
            UITabBar.appearance().backgroundImage = UIImage()
        }
        tabBar.backgroundColor = ColorPalette.strongBlue
        tabBar.tintColor = ColorPalette.orange
        tabBarItem.setTitleTextAttributes([.font: UIFont(name: AppFont.medium.name, size: 10)!], for: .normal)

        if let viewControllers = viewControllers {
            for viewController in viewControllers {
                viewController.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5.5, left: 0, bottom: -5.5, right: 0)
            }
        }
    }

    func setupChilds() {
        guard let viewModel = viewModel as? TabbarViewModel else { return }
        let homeVC = HomeViewController.fromNib()
        homeVC.set(viewModel: viewModel.createHomeViewModel(), navigator: self.navigator)
        homeVC.tabBarItem.image = UIImage(named: "home_ic")
        let homeNav = UINavigationController(rootViewController: homeVC)

        let videoVC = VideoViewController.fromNib()
        videoVC.set(viewModel: viewModel.createVideoViewModel(), navigator: self.navigator)
        videoVC.tabBarItem.image = UIImage(named: "video_ic")
        let videoNav = UINavigationController(rootViewController: videoVC)

        let profileVC = ProfileViewController.fromNib()
        profileVC.set(viewModel: viewModel.createProfileViewModel(), navigator: self.navigator)
        profileVC.tabBarItem.image = UIImage(named: "profile_ic")
        let profileNav = UINavigationController(rootViewController: profileVC)

        self.viewControllers = [homeNav, videoNav, profileNav]
    }
}
