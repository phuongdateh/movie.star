//
//  VideoTableViewCell.swift
//  core
//
//  Created by phuong.doand on 14/09/2021.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subInfoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var video: VideoCategory!
    
    func bind(video: VideoCategory) {
        titleLbl.text = video.video.name
        YoutubeService.shared.getVideo(by: video.video.key) { _ in
            
        }
    }
}
