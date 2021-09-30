//
//  RecommendationMovieCollectionViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 30/09/2021.
//

import UIKit

class RecommendationMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var releaseDateLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbnailImageView.contentMode = .scaleAspectFill
        self.thumbnailImageView.layer.cornerRadius = 5
        self.ratingView.settings.starSize = 10
    }

    func configureData(movie: Movie) {
        self.thumbnailImageView.downloadImage(with: .tmdb(movie.backdropPath ?? ""))
        self.titleLbl.text = movie.title
        self.ratingView.rating = movie.voteAverage
        self.releaseDateLbl.text = movie.releaseDate
    }
}
