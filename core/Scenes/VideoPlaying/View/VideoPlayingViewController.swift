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
    
    private var movieDetail: MovieDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        
    }
    
    override func bindViewModel() {
        self.movieDetail = viewModel.category.movieDetail
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
        
        self.updateView()
    }
    
    var player: BMPlayer!
    
    func setupPlayer() {
        player = BMPlayer(customControlView: BMPlayerCustomControlView.init())
        view.addSubview(player)
        player.snp.makeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(view.snp.top)
            }
            make.left.right.equalTo(self.view)
            // Note here, the aspect ratio 16:9 priority is lower than 1000 on the line, because the 4S iPhone aspect ratio is not 16:9
            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        // Back button event
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true { return }
            self.dismiss(animated: true, completion: nil)
        }
        player.delegate = self
    }
    
    private func updateView() {
        
    }
}

extension VideoPlayingViewController: BMPlayerDelegate {
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        
    }
    
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        
    }
    
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
        player.snp.remakeConstraints { (make) in
            if #available(iOS 11, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            } else {
                make.top.equalTo(view.snp.top)
            }
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            if isFullscreen {
                make.bottom.equalTo(view.snp.bottom)
            } else {
                make.height.equalTo(view.snp.width).multipliedBy(9.0/16.0).priority(500)
            }
        }
    }
}
