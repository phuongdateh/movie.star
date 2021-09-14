//
//  VideoViewController.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import UIKit
import XCDYouTubeKit
import SnapKit
import AVKit

class VideoViewController: ViewController<VideoViewModel> {

    var player: BMPlayer!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        player = BMPlayer()
//        view.addSubview(player)
//        player.snp.makeConstraints { (make) in
//            make.top.equalTo(self.view).offset(20)
//            make.left.right.equalTo(self.view)
//            // Note here, the aspect ratio 16:9 priority is lower than 1000 on the line, because the 4S iPhone aspect ratio is not 16:9
//            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
//        }
//        // Back button event
//        player.backBlock = { [unowned self] (isFullScreen) in
//            if isFullScreen == true { return }
//            let _ = self.navigationController?.popViewController(animated: true)
//        }
//
//        var streamURL: URL!
//
//        XCDYouTubeClient.default().getVideoWithIdentifier("HZi4eJXWZU0") { video, error in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            guard let video = video else { return }
//            if let url = video.streamURLs[XCDYouTubeVideoQuality.HD720.rawValue]  {
//                streamURL = url
//            }
//            else if let url = video.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] {
//                streamURL = url
//            }
//            else if let url = video.streamURLs[XCDYouTubeVideoQuality.small240.rawValue] {
//                streamURL = url
//            }
//            else if let urlDict = video.streamURLs.first {
//                streamURL = urlDict.value
//            }
//
//            let asset = BMPlayerResource(url: video.streamURL!,
//                                         name: video.title)
//            self.player.setVideo(resource: asset)
//        }
    }
    
    override func makeUI() {
        tableView.registerCell(ofType: VideoTableViewCell.self)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func bindViewModel() {
        viewModel.prepareData()
        viewModel.didDataChange = {
            self.tableView.reloadData()
        }
    }
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: VideoTableViewCell.self, at: indexPath)
        cell.selectionStyle = .none
        cell.bind(category: viewModel.videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
