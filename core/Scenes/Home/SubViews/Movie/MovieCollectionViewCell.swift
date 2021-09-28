//
//  MovieCollectionViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 28/09/2021.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releasedDateLbl: UILabel!
    @IBOutlet weak var voteAverageLbl: UILabel!
    @IBOutlet weak var voteAverageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }
    
    private func configureView() {
        self.releasedDateLbl.setFont(appFont: .medium, size: 14, color: .gray)
        self.titleLbl.setFont(appFont: .bold, size: 16)
        self.thumbnailImageView.contentMode = .scaleAspectFill
        self.thumbnailImageView.layer.cornerRadius = 5
        self.voteAverageView.layer.cornerRadius = 5
    }
    
    func configure(_ movie: Movie) {
        self.thumbnailImageView.retrivingImage(path: movie.backdropPath ?? "")
        self.titleLbl.text = movie.originalTitle
        self.releasedDateLbl.text = movie.releaseDate
        let voteAverageText = NSMutableAttributedString.init()
        voteAverageText.append(NSAttributedString(string: "IMDb ",
                                                  attributes: [.font: UIFont(name: AppFont.bold.name, size: 14)!,
                                                                .foregroundColor: UIColor.black]))
        voteAverageText.append(NSAttributedString(string: "\(movie.voteAverage)",
                                                  attributes: [.font: UIFont(name: AppFont.bold.name, size: 12)!,
                                                                .foregroundColor: UIColor.red]))
        voteAverageLbl.attributedText = voteAverageText
    }
}
