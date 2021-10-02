//
//  ViewController.swift
//  core
//
//  Created by phuong.doan on 6/30/21.
//

import UIKit
import AVKit
import XCDYouTubeKit

class ViewController<VM: ViewModel>: UIViewController,
                                     Navigatable,
                                     AVPlayerViewControllerDelegate {
    
    var navigator: Navigator!
    var viewModel: VM!
    
    var navigationTitle: String = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    func set(viewModel: VM, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeUI()
        bindViewModel()
    }
    
    func makeUI() {
        
        updateUI()
    }
    
    func bindViewModel() {
        
    }
    
    func updateUI() {
        
    }
    
    func showTrailer(video: Video) {
        let playerVC = AVPlayerViewController()
        present(playerVC, animated: true, completion: nil)
        XCDYouTubeClient.default().getVideoWithIdentifier(video.key) {[weak self, weak playerVC] (video, error) in
            if let _ = error {
                self?.dismiss(animated: true, completion: nil)
                return
            }
            guard let video = video else {
                self?.dismiss(animated: true, completion: nil)
                return
            }
            let streamURL: URL
            if let url = video.streamURLs[XCDYouTubeVideoQuality.HD720.rawValue]  {
                streamURL = url
            }
            else if let url = video.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] {
                streamURL = url
            }
            else if let url = video.streamURLs[XCDYouTubeVideoQuality.small240.rawValue] {
                streamURL = url
            }
            else if let urlDict = video.streamURLs.first {
                streamURL = urlDict.value
            }
            else {
                self?.dismiss(animated: true, completion: nil)
                return
            }
            playerVC?.delegate = self
            playerVC?.player = AVPlayer(url: streamURL)
            playerVC?.player?.play()
        }
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController,
                              willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        playerViewController.dismiss(animated: true) { [weak self] in
            if let weakSelf = self {
                // Show ads
            }
        }
    }
}

