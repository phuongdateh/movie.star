//
//  MovieDetailViewController.swift
//  core
//
//  Created by Doan Duy Phuong on 28/09/2021.
//

import UIKit

class MovieDetailViewController: ViewController<MovieDetailViewModel> {

    @IBOutlet weak var backButton: LumiKitBackButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var overlayViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var detailWrapperView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var originTitleLbl: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var voteAvegareValueLbl: UILabel!

    @IBOutlet weak var genresLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!

    // Admod
    @IBOutlet weak var nativeAdsView: UIView!
    
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var moreButtonView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        self.detailWrapperView.layer.cornerRadius = 20

        self.posterImageView.contentMode = .scaleAspectFill
        self.posterImageViewHeightConstraint.constant = Helpers.screenSize().width

        self.overlayViewHeightConstraint.constant = Helpers.screenSize().width / 2

        self.scrollView.delegate = self

        self.thumbnailImageView.contentMode = .scaleAspectFill
        self.thumbnailImageView.layer.cornerRadius = 5
        
        self.overviewLbl.numberOfLines = 3
        self.moreButton.tintColor = UIColor.gray
        self.moreButton.setTitle("More", for: .normal)
        self.moreButton.titleLabel?.setFont(appFont: .medium, size: 14)
    }
    
    override func bindViewModel() {
        self.viewModel.retrieveMovieDetail(success: { [weak self] in
            DispatchQueue.main.async {
                self?.updateView()
            }
        }, error: { msg in
            
        })
    }
    
    private func updateView() {
        guard let movie = self.viewModel.getMovieDetail() else { return }
        self.posterImageView.downloadImage(with: .tmdb(movie.posterPath ?? ""))
        self.thumbnailImageView.downloadImage(with: .tmdb(movie.backdropPath ?? ""))
        self.ratingView.rating = movie.voteAverage
        self.originTitleLbl.text = movie.originalTitle
        self.releaseDateLbl.text = "Date of Release: " + (movie.releaseDate ?? "")
        self.durationLbl.text = "Durations: \(movie.runtime) mins"
        if let genres = movie.genres, genres.isEmpty == false {
            var genresStr: String = "Category: "
            let names = genres.map({ $0.name })
            for (index, item) in names.enumerated() {
                genresStr += item
                if index != names.count {
                    genresStr += ", "
                }
            }
            self.genresLbl.text = genresStr
        } else {
            genresLbl.text = ""
        }
        self.voteAvegareValueLbl.text = "\(movie.voteAverage)"
        
        self.overviewLbl.text = movie.overview
        
        self.renderAdsView()
        self.renderMoreButtonView()
    }
    
    private func renderAdsView() {
        self.nativeAdsView.isHidden = !viewModel.isShouldShowAdsView()
    }
    
    private func renderMoreButtonView() {
        if self.overviewLbl.lineCount() > 3 {
            self.moreButtonView.isHidden = false
        } else {
            self.moreButtonView.isHidden = true
        }
    }
}

extension MovieDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let realFullAppearOffsetY = Helpers.screenSize().width
        let realCurrentOffsetY = scrollView.contentOffset.y
        if (realFullAppearOffsetY - realCurrentOffsetY) >= 0 {
            posterImageViewHeightConstraint.constant = realFullAppearOffsetY - realCurrentOffsetY
        } else {
            posterImageViewHeightConstraint.constant = 0
        }
    }
}

extension MovieDetailViewController {
    @IBAction func moreButtonTouchUpInside(_ sender: UIButton) {
        overviewLbl.numberOfLines = 0
        self.moreButtonView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func backButtonTouchUpInside(_ sender: LumiKitBackButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func playButtonTouchUpInside(_ sender: PlayButton) {
        print(#function)
    }
}
