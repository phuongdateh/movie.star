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
        
        thumbnailImageView.contentMode = .scaleAspectFill
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = 25
        
        titleLbl.font = UIFont(name: AppFont.regular.name, size: 14)
        titleLbl.textColor = UIColor.black
        
        subInfoLbl.font = UIFont(name: AppFont.medium.name, size: 12)
        subInfoLbl.textColor = UIColor.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var category: VideoCategory!
    
    func bind(category: VideoCategory) {
        titleLbl.text = category.video.name
        thumbnailImageView.downloadImage(with: .youtube(category.video.key))
        movieImageView.downloadImage(with: .tmdb(category.movie.backdropPath ?? category.movie.posterPath ?? ""))
        subInfoLbl.text = "Release Dates: " + (category.movie.releaseDate ?? "")
    }
}
