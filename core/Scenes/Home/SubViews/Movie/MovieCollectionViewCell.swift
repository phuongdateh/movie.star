//
//  MovieCollectionViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 28/09/2021.
//

import UIKit

final class MovieCollectionViewCell: BaseCollectionViewCell {

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
    
    override func configureMovie(_ movie: Movie) {
        self.thumbnailImageView.downloadImage(with: .tmdb(movie.backdropPath ?? movie.posterPath ?? ""))
        self.titleLbl.text = movie.name ?? movie.title
        self.releasedDateLbl.text = movie.firstAirDate ?? movie.releaseDate
        let voteAverageText = NSMutableAttributedString.init()
        voteAverageText.append(NSAttributedString(string: "IMDb ",
                                                  attributes: [.font: UIFont(name: AppFont.bold.name, size: 14)!,
                                                                .foregroundColor: UIColor.black]))
        voteAverageText.append(NSAttributedString(string: "\(movie.voteAverage)",
                                                  attributes: [.font: UIFont(name: AppFont.bold.name, size: 12)!,
                                                                .foregroundColor: UIColor.red]))
        voteAverageLbl.attributedText = voteAverageText
    }
    
    func configure(_ movie: MovieProtocol) {
        self.thumbnailImageView.downloadImage(with: .tmdb(movie.getBackdropPath() ?? movie.getPosterPath() ?? ""))
        self.titleLbl.text = movie.getTitle()
        self.releasedDateLbl.text = movie.getReleaseDate()
        let voteAverageText = NSMutableAttributedString.init()
        voteAverageText.append(NSAttributedString(string: "IMDb ",
                                                  attributes: [.font: UIFont(name: AppFont.bold.name, size: 14)!,
                                                                .foregroundColor: UIColor.black]))
        voteAverageText.append(NSAttributedString(string: "\(movie.getVoteAverage())",
                                                  attributes: [.font: UIFont(name: AppFont.bold.name, size: 12)!,
                                                                .foregroundColor: UIColor.red]))
        voteAverageLbl.attributedText = voteAverageText
    }
}
