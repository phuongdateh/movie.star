//
//  VideoPlayingViewController.swift
//  core
//
//  Created by phuong.doand on 14/09/2021.
//

import UIKit
import SnapKit
import XCDYouTubeKit
import AVKit

class VideoPlayingViewController: ViewController<VideoPlayingViewModel> {

    @IBOutlet weak var playerView: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        closeButton.setTitle(nil, for: .normal)
        closeButton.tintColor = .white
    }
    
    override func bindViewModel() {
        self.setupPlayer()
        var streamURL: URL!
        
        YoutubeService.shared.getVideo(by: viewModel.category.video.key) { video in
            print("VideoPlayingViewController: \(video?.video.title)")
            guard let youtobeVideo = video else { return }
            let video = youtobeVideo.video
//            if let url = video.streamURLs[XCDYouTubeVideoQuality.HD720.rawValue]  {
//                streamURL = url
//            }
            if let url = video.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] {
                streamURL = url
            }
            else if let url = video.streamURLs[XCDYouTubeVideoQuality.small240.rawValue] {
                streamURL = url
            }
            else if let urlDict = video.streamURLs.first {
                streamURL = urlDict.value
            } else {
                streamURL = video.streamURL
            }
            
            let asset = BMPlayerResource(url: video.streamURL!,
                                         name: video.title)
            self.player.setVideo(resource: asset)
        }
    }
    
    var player: BMPlayer!
    
    func setupPlayer() {
        player = BMPlayer()
        playerView.addSubview(player)
        player.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view.safeAreaInsets.bottom).offset(44)
//            make.left.right.equalTo(self.view)
//            // Note here, the aspect ratio 16:9 priority is lower than 1000 on the line, because the 4S iPhone aspect ratio is not 16:9
//            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
            make.edges.equalToSuperview()
        }
        // Back button event
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true { return }
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func closeButtonTouchUpInside(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension UITabBarController {

    /**
     Show or hide the tab bar.
     - Parameter hidden: `true` if the bar should be hidden.
     - Parameter animated: `true` if the action should be animated.
     - Parameter transitionCoordinator: An optional `UIViewControllerTransitionCoordinator` to perform the animation
        along side with. For example during a push on a `UINavigationController`.
     */
    func setTabBar(hidden: Bool,
                   animated: Bool = true,
                   along transitionCoordinator: UIViewControllerTransitionCoordinator? = nil) {
        guard isTabBarHidden != hidden else { return }

        let offsetY = hidden ? tabBar.frame.height : -tabBar.frame.height
        let endFrame = tabBar.frame.offsetBy(dx: 0, dy: offsetY)
        let vc: UIViewController? = viewControllers?[selectedIndex]
        var newInsets: UIEdgeInsets? = vc?.additionalSafeAreaInsets
        let originalInsets = newInsets
        newInsets?.bottom -= offsetY

        /// Helper method for updating child view controller's safe area insets.
        func set(childViewController cvc: UIViewController?, additionalSafeArea: UIEdgeInsets) {
            cvc?.additionalSafeAreaInsets = additionalSafeArea
            cvc?.view.setNeedsLayout()
        }

        // Update safe area insets for the current view controller before the animation takes place when hiding the bar.
        if hidden, let insets = newInsets { set(childViewController: vc, additionalSafeArea: insets) }

        guard animated else {
            tabBar.frame = endFrame
            return
        }

        // Perform animation with coordinato if one is given. Update safe area insets _after_ the animation is complete,
        // if we're showing the tab bar.
        weak var tabBarRef = self.tabBar
        if let tc = transitionCoordinator {
            tc.animateAlongsideTransition(in: self.view, animation: { _ in tabBarRef?.frame = endFrame }) { context in
                if !hidden, let insets = context.isCancelled ? originalInsets : newInsets {
                    set(childViewController: vc, additionalSafeArea: insets)
                }
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: { tabBarRef?.frame = endFrame }) { didFinish in
                if !hidden, didFinish, let insets = newInsets {
                    set(childViewController: vc, additionalSafeArea: insets)
                }
            }
        }
    }

    /// `true` if the tab bar is currently hidden.
    var isTabBarHidden: Bool {
        return !tabBar.frame.intersects(view.frame)
    }
}
