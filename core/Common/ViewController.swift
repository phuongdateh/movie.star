//
//  ViewController.swift
//  core
//
//  Created by phuong.doan on 6/30/21.
//

import UIKit
import AVKit
import XCDYouTubeKit
import SnapKit

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
        self.configColorNavigationBar()
    }
    
    func configColorNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = ColorPalette.strongBlue
        appearance.titleTextAttributes = [.font: UIFont(name: AppFont.bold.name, size: 18)!,
                                          .foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    func makeUI() {
        
        updateUI()
    }
    
    func bindViewModel() {
        
    }
    
    func updateUI() {
        
    }
    
    func addBackButton() {
        if let navigationController = self.navigationController,
           let index = navigationController.viewControllers.firstIndex(of: self), index > 0
            || navigationController.presentingViewController != nil {
            let imageView = UIImageView(image: UIImage(named: "back_ic"))
            imageView.tintColor = .white
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AboutViewController.backAction)))
            let leftBarButton = UIBarButtonItem(customView: imageView)
            self.navigationItem.leftBarButtonItem = leftBarButton
        }
    }
    
    @objc private func backAction() {
        self.navigationController?.popViewController(animated: true)
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
    
    let vc = UIViewController()
    func shouldShowLoading(isShow: Bool) {
        let indictorView = IndicatorType.ballSpinFadeLoader.view(frame: vc.view.frame,
                                                                 with: .lightGray)
        vc.view.backgroundColor = ColorPalette.background
        vc.view.addSubview(indictorView)
        indictorView.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.centerX.equalTo(vc.view)
            make.centerY.equalTo(vc.view)
        }
        if isShow {
            self.presentOverContext(vc, animated: true, completion: nil)
        } else {
            vc.dismiss(animated: true, completion: nil)
        }
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController,
                              willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        playerViewController.dismiss(animated: true) {
            // show ads
        }
    }
    
    func share(content: String, viewClick: UIView, completion: (() -> Void)? = nil) {
        let objectsToShare = [content] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop,
                                            UIActivity.ActivityType.addToReadingList,
                                            .message]
        self.present(activityVC, animated: true, completion: nil)
        if let popOver = activityVC.popoverPresentationController {
            popOver.sourceView = viewClick
        }
    }
}

extension UIViewController {
    func presentOverContext(_ viewController: UIViewController, animated: Bool = true, completion: (()->())? = nil) {
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        if let tabBarController = tabBarController {
            DispatchQueue.main.async {
                tabBarController.present(viewController, animated: animated, completion: completion)
            }
        } else if let navigationController = navigationController {
            DispatchQueue.main.async {
                navigationController.present(viewController, animated: animated, completion: completion)
            }
        } else {
            DispatchQueue.main.async {[weak self] in
                self?.present(viewController, animated: animated, completion: completion)
            }
        }
    }
}

