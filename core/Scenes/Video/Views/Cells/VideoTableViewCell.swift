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
    
    @IBOutlet weak var runtimeLbl: UILabel!
    @IBOutlet weak var runtimeView: UIView!
    
    @IBOutlet weak var playButtonView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        thumbnailImageView.contentMode = .scaleAspectFill
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = 25
        
        titleLbl.font = UIFont(name: AppFont.regular.name, size: 14)
        titleLbl.textColor = UIColor.white
        
        subInfoLbl.font = UIFont(name: AppFont.medium.name, size: 12)
        subInfoLbl.textColor = UIColor.gray
        
        runtimeView.layer.cornerRadius = 5
        runtimeView.backgroundColor = UIColor.black
        runtimeLbl.font = UIFont(name: AppFont.medium.name, size: 10)
        runtimeLbl.textColor = UIColor.white
        runtimeLbl.text = ""
        runtimeView.alpha = 0
        
        playButtonView.layer.cornerRadius = playButtonView.frame.width / 2
    }

    var category: VideoCategory!
    
    func bind(category: VideoCategory) {
        titleLbl.text = category.video.name
        thumbnailImageView.downloadImage(with: .youtube(category.video.key))
        movieImageView.downloadImage(with: .tmdb(category.movieDetail.backdropPath ?? category.movieDetail.posterPath ?? ""))
        subInfoLbl.text = "Release Dates: " + (category.movieDetail.releaseDate ?? "")
    }
}

extension Int {
    func convertHourMinuteStr() -> String {
        let hourStr: String = "\((self % 3600) / 60)"
        let minuteStr: String = "\((self % 3600) % 60)"
        return "\(hourStr) : \(minuteStr)"
    }
}

