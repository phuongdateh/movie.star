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
        
        thumbnailImageView.contentMode = .scaleAspectFit
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var category: VideoCategory!
    
    func bind(category: VideoCategory) {
        titleLbl.text = category.video.name
        thumbnailImageView.downloadImage(with: .youtube(category.video.key))
        YoutubeService.shared.getVideo(by: category.video.key) { video in
            print("==================== \(video?.video.title)")
        }
    }
}
