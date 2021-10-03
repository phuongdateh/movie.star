//
//  MovieListCollectionViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 02/10/2021.
//

import UIKit

class MovieListCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var durationsLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var ratingView: RatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configurateView()
    }
    
    private func configurateView() {
        self.backgroundColor = .clear
        self.posterImageView.contentMode = .scaleAspectFill
        self.posterImageView.layer.cornerRadius = 5
        
        self.loveButton.setTitle("", for: .normal)
        self.wrapperView.addShadow()
        self.wrapperView.layer.cornerRadius = 10
        self.wrapperView.backgroundColor = ColorPalette.strongBlue
    }
    
    override func configureMovie(_ movie: Movie) {
        self.posterImageView.downloadImage(with: .tmdb(movie.backdropPath ?? movie.posterPath ?? ""))
        self.titleLbl.text = movie.title ?? movie.originalTitle
        self.releaseDateLbl.text = movie.releaseDate
        self.genresLbl.text = ""
        self.ratingView.rating = movie.voteAverage
    }
    

    @IBAction func loveButonTouchUpInside(_ sender: UIButton) {
        
    }
    
}
