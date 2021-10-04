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
    
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var trailerSectionView: UIView!
    @IBOutlet weak var trailerSectionViewHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var reviewSectionView: UIView!
    @IBOutlet weak var reviewLbl: UILabel!
    
    @IBOutlet weak var creditsSectionView: UIView!
    @IBOutlet weak var recommendationsSectionView: UIView!
    @IBOutlet weak var recommendationsSectionViewHeightConstraint: NSLayoutConstraint!
    
    private var trailerView: TrailerView? { return TrailerView.fromNib()}
    private var recommendationsView: RecommendationsView? { return RecommendationsView.fromNib() }
    private var creditsView: CreditsView? { return CreditsView.fromNib() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        self.view.backgroundColor = ColorPalette.background
        self.detailWrapperView.backgroundColor = ColorPalette.background
        self.detailWrapperView.layer.cornerRadius = 20

        self.posterImageView.addShadow()
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
        
        self.loveButton.backgroundColor = ColorPalette.strongBlue
        self.shareButton.backgroundColor = ColorPalette.strongBlue
        self.loveButton.layer.cornerRadius = 15
        self.shareButton.layer.cornerRadius = 15
        self.loveButton.addShadow()
        self.shareButton.addShadow()
    }
    
    override func bindViewModel() {
        self.shouldShowLoading(isShow: true)
        self.viewModel.retrieveMovieDetail(success: { [weak self] in
            DispatchQueue.main.async {
                self?.updateView()
                self?.shouldShowLoading(isShow: false)
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
                if index != names.count - 1 {
                    genresStr += ", "
                }
            }
            self.genresLbl.text = genresStr
        } else {
            genresLbl.text = ""
        }
        self.voteAvegareValueLbl.text = "\(movie.voteAverage)"

        self.overviewLbl.text = movie.overview

        if let reviews = movie.reviews {
            reviewLbl.text = "Rating & reivews: \(reviews.results.count) ratings"
        }
        
        if let credit = movie.credits,
           let view = self.creditsView {
            view.configure(credits: credit)
            view.delegate = self
            creditsSectionView.addChildView(view: view)
        }
        
        if let recommendations = movie.recommendations,
           let view = recommendationsView {
            view.delegate = self
            view.configureData(recommendations.results)
            recommendationsSectionView.addChildView(view: view)
        }
        
        if let videoResults = movie.videos,
            let view = trailerView {
            view.configureData(videos: videoResults.results)
            view.delegate = self
            trailerSectionView.addChildView(view: view)
        }
        
        if movie.isFavorite() {
            loveButton.tintColor = ColorPalette.orange
        } else {
            loveButton.tintColor = .white
        }

        self.renderAdsView()
        self.renderMoreButtonView()
        self.renderReviewSectionView(isShow: movie.reviews == nil)
        self.renderCreditsSectionView(isShow: movie.credits == nil)
        self.renderRecommendationsSectionView(isShow: movie.recommendations?.results.isEmpty ?? false)
        self.renderTrailerSectionView(isShow: movie.videos?.results.isEmpty ?? false)
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

    private func renderReviewSectionView(isShow: Bool) {
        self.reviewSectionView.isHidden = isShow
    }
    
    private func renderCreditsSectionView(isShow: Bool) {
        self.creditsSectionView.isHidden = isShow
    }
    
    private func renderRecommendationsSectionView(isShow: Bool) {
        self.recommendationsSectionViewHeightConstraint.constant = RecommendationsView.height()
        self.recommendationsSectionView.isHidden = isShow
    }
    
    private func renderTrailerSectionView(isShow: Bool) {
        self.trailerSectionViewHeightConstraint.constant = TrailerView.height
        self.trailerSectionView.isHidden = isShow
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
//        if let viewControllers = self.navigationController?.viewControllers,
//           viewControllers.count > 1,
//           let firstVC = viewControllers.first(where: { vc in
//            if vc is HomeViewController {
//                return true
//            }
//            return false
//        }) {
//            self.navigationController?.popToViewController(firstVC, animated: true)
//        } else {
//            self.navigationController?.popViewController(animated: true)
//        }
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func playButtonTouchUpInside(_ sender: PlayButton) {
        guard let detail = viewModel.getMovieDetail(),
              let videoResults = detail.videos,
                videoResults.results.isNotEmpty else { return }
        let firstVideo = videoResults.results.first!
        self.showTrailer(video: firstVideo)
    }

    @IBAction func shareButtonTouchUpInside(_ sender: UIButton) {
        guard let detail = viewModel.getMovieDetail() else {
            return
        }
        let shareLinkStr: String = "https://www.themoviedb.org/movie/"
        self.share(content: shareLinkStr + "\(detail.id)", viewClick: self.shareButton, completion: nil)
    }

    @IBAction func loveButtonTouchUpInside(_ sender: UIButton) {
        guard let detail = viewModel.getMovieDetail() else {
            return
        }
        MovieRealm.favorite(movie: detail)
        if loveButton.tintColor == ColorPalette.orange {
            loveButton.tintColor = .white
        } else {
            loveButton.tintColor = ColorPalette.orange
        }
        
        print("CurrentList: \(MovieRealm.currentList().count)")
    }
}
