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
    @IBOutlet weak var tableView: UITableView!
    
    private var movieDetail: MovieDetail!
    private var isSeemore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func makeUI() {
        tableView.registerCell(ofType: VideoPlayingHeaderTableViewCell.self)
        tableView.registerCell(ofType: VideoPlayingTableViewCell.self)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = ColorPalette.background
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = ColorPalette.background
    }
    
    private var source: YoutubeVideo?
    override func bindViewModel() {
        self.movieDetail = viewModel.category.movieDetail
        self.setupPlayer()
        self.playVideo(key: viewModel.category.video.key)
        self.updateView()
    }
    
    var player: BMPlayer!
    
    func playVideo(key: String) {
        YoutubeService.shared.getVideo(by: key) { video in
            guard let youtobeVideo = video else { return }
            var streamURL: URL!
            self.source = youtobeVideo
            let video = self.source!.video
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
            
            let asset = BMPlayerResource(url: streamURL,
                                         name: video.title)
            self.player.setVideo(resource: asset)
            self.isSeemore = false
            self.tableView.reloadData()
        }
    }
    
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

extension VideoPlayingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = source {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if let videoResults = movieDetail.videos {
            return videoResults.results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(ofType: VideoPlayingHeaderTableViewCell.self, at: indexPath)
            cell.updateAction = {
                self.isSeemore = true
                tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
            }
            if let source = self.source {
                cell.binds(source: source,
                           isSeeMore: self.isSeemore)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(ofType: VideoPlayingTableViewCell.self, at: indexPath)
            cell.selectionStyle = .none
            cell.configure(video: movieDetail.videos!.results[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let video = movieDetail.videos!.results[indexPath.row]
            self.playVideo(key: video.key)
        }
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
