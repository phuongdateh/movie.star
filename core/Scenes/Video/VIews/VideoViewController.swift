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
    @IBOutlet weak var playerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = BMPlayer()
        view.addSubview(player)
        player.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.right.equalTo(self.view)
            // Note here, the aspect ratio 16:9 priority is lower than 1000 on the line, because the 4S iPhone aspect ratio is not 16:9
            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        // Back button event
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true { return }
            let _ = self.navigationController?.popViewController(animated: true)
        }

        var streamURL: URL!
        
        XCDYouTubeClient.default().getVideoWithIdentifier("NYdNN6C9hfI") { video, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let video = video else { return }
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

            let asset = BMPlayerResource(url: video.streamURL!,
                                         name: "风格互换：原来你我相爱")
            self.player.setVideo(resource: asset)
        }
    }
}
