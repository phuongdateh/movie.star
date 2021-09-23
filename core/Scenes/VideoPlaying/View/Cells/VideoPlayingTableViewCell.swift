//
//  VideoPlayingTableViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 22/09/2021.
//

import UIKit

class VideoPlayingTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleVideoLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.contentMode = .scaleAspectFill
        self.backgroundColor = ColorPalette.background
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(video: Video) {
        titleVideoLbl.text = video.name
        thumbnailImageView.downloadImage(with: .youtube(video.key))
    }
}
