//
//  CreditsDetailViewController.swift
//  core
//
//  Created by Doan Duy Phuong on 01/10/2021.
//

import UIKit

extension Array {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

class CreditsDetailViewController: ViewController<CreditsDetailViewModel> {
    
    private let movieCreditsViewHeight: CGFloat = 350
    private let tvCreditsViewHeight: CGFloat = 390
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var overlayViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var biographySectionView: UIView!
    @IBOutlet weak var biographyLbl: UILabel!
    
    @IBOutlet weak var moreButtonSectionView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var bornSectionView: UIView!
    @IBOutlet weak var bornLbl: UILabel!
    
    @IBOutlet weak var placeOfBirthSectionView: UIView!
    @IBOutlet weak var placeOfBirthLbl: UILabel!
    
    @IBOutlet weak var alsoKnownAsSectionView: UIView!
    @IBOutlet weak var alsoKnownAsLbl: UILabel!
    
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var adsSectionView: UIView!
    
    @IBOutlet weak var movieCreditsSectionView: UIView!
    @IBOutlet weak var movieCreditsSectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tvCreditsSectionView: UIView!
    @IBOutlet weak var tvCreditsSectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imagesSectionView: UIView!
    @IBOutlet weak var imagesSectionViewHeightConstraint: NSLayoutConstraint!
    
    
    private var person: PersonDetail {
        guard let person = viewModel.getPersonDetail() else {
            fatalError("Fail")
        }
        return person
    }
    
    private var movieCredistView: HorizontalMovieView<RecommendationMovieCollectionViewCell>!
    private var tvCreditsView: HorizontalMovieView<MovieCollectionViewCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurateView()
    }
    
    private func configurateView() {
        self.scrollView.delegate = self
        contentView.addShadow()
        contentView.layer.cornerRadius = 20
        posterImageView.contentMode = .scaleAspectFill
        posterImageViewHeightConstraint.constant = Helpers.screenSize().width
        
        overlayViewHeightConstraint.constant = 4/5 * Helpers.screenSize().width
        
        self.biographyLbl.numberOfLines = 3
        self.moreButton.tintColor = UIColor.gray
        self.moreButton.setTitle("More", for: .normal)
        self.moreButton.titleLabel?.setFont(appFont: .medium, size: 14)
        
        self.loveButton.layer.cornerRadius = 15
        self.shareButton.layer.cornerRadius = 15
        self.loveButton.addShadow()
        self.shareButton.addShadow()
        
        self.movieCredistView = HorizontalMovieView<RecommendationMovieCollectionViewCell>.init(frame: CGRect(x: 0,
                                                                                                              y: 0,
                                                                                                              width: self.movieCreditsSectionView.frame.width,
                                                                                                              height: self.movieCreditsViewHeight))
        self.movieCreditsSectionView.addChildView(view: self.movieCredistView)
        
        self.tvCreditsView = HorizontalMovieView<MovieCollectionViewCell>.init(frame: CGRect(x: 0,
                                                                                             y: 0,
                                                                                             width: self.tvCreditsSectionView.frame.width,
                                                                                             height: self.movieCreditsViewHeight))
        self.tvCreditsSectionView.addChildView(view: self.tvCreditsView)
    }
    
    override func bindViewModel() {
        self.shouldShowLoading(isShow: true)
        viewModel.retrievePersonDetail(success: {[weak self] in
            DispatchQueue.main.async {
                self?.updateView()
                self?.shouldShowLoading(isShow: false)
            }
        }, error: { msg in
            
        })
    }
    
    private func updateView() {
        self.nameLbl.text = person.name
        self.posterImageView.downloadImage(with: .tmdb(person.profilePath ?? ""))
        
        self.renderBiographySectionView()
        self.renderBornSectionView()
        self.renderPlaceOfBirthSectionView()
        self.renderAlsoKnownAsSectionView()
        self.renderMoreButtonSectionView()
        self.renderAdsSectionView()
        self.renderMovieCreditsSectionView()
        self.renderTvCreditsSectionView()
    }
    
    private func renderMovieCreditsSectionView() {
        guard let movieCredits = person.movieCredits else {
            self.movieCreditsSectionView.isHidden = true
            return
        }
        if movieCredits.crew.isNotEmpty || movieCredits.crew.isNotEmpty {
            let movies = movieCredits.crew + movieCredits.cast
            self.movieCredistView.configureMovies(movies,
                                                  title: "Movie Credits",
                                                  sizeForItem: .init(width: 200, height: 320))
            self.movieCreditsSectionView.isHidden = false
            self.movieCreditsSectionViewHeightConstraint.constant = self.movieCreditsViewHeight
            self.movieCredistView.didSelectViewAll = { title, movies in
                self.navigator.show(segue: .movieList(title: title,
                                                      movies: movies,
                                                      genre: nil,
                                                      item: nil),
                                    sender: self)
            }
            self.movieCredistView.didSelectMovieItem = { movieId in
                self.navigator.show(segue: .movieDetail(moviedId: movieId), sender: self)
            }
        } else {
            self.movieCreditsSectionView.isHidden = true
        }
    }
    
    private func renderTvCreditsSectionView() {
        guard let tvCredits = person.tvCredits else {
            self.tvCreditsSectionView.isHidden = true
            return
        }
        if tvCredits.crew.isNotEmpty || tvCredits.crew.isNotEmpty {
            let movies = tvCredits.crew + tvCredits.cast
            self.tvCreditsView.configureMovies(movies,
                                               title: "TV Credits",
                                               sizeForItem: .init(width: 200, height: 320))
            self.tvCreditsSectionView.isHidden = false
            self.tvCreditsSectionViewHeightConstraint.constant = self.tvCreditsViewHeight
            self.tvCreditsView.didSelectViewAll = { title, movies in
                self.navigator.show(segue: .movieList(title: title,
                                                      movies: movies,
                                                      genre: nil,
                                                      item: nil),
                                    sender: self)
            }
            self.tvCreditsView.didSelectMovieItem = { movieId in
                self.navigator.show(segue: .movieDetail(moviedId: movieId), sender: self)
            }
        } else {
            self.tvCreditsSectionView.isHidden = true
        }
    }
    
    private func renderAdsSectionView() {
        self.adsSectionView.isHidden = viewModel.isShouldShowAdsView()
    }
    
    private func renderMoreButtonSectionView() {
        if self.biographyLbl.lineCount() > 3 {
            self.moreButtonSectionView.isHidden = false
        } else {
            self.moreButtonSectionView.isHidden = true
        }
    }
    
    private func renderAlsoKnownAsSectionView() {
        if let arrStr = person.alsoKnownAs,
           arrStr.isEmpty == false {
            var resultStr: String = ""
            for (index, item) in arrStr.enumerated() {
                resultStr += item
                if index != arrStr.count - 1 {
                    resultStr += ", "
                }
            }
            self.alsoKnownAsLbl.text = resultStr
            self.alsoKnownAsSectionView.isHidden = false
        } else {
            self.alsoKnownAsSectionView.isHidden = true
        }
    }
    
    private func renderPlaceOfBirthSectionView() {
        self.placeOfBirthLbl.text = self.person.placeOfBirth
        self.placeOfBirthSectionView.isHidden = self.person.placeOfBirth == nil
    }
    
    private func renderBiographySectionView() {
        if let text = person.biography,
           text.isEmpty == false {
            self.biographySectionView.isHidden = false
            self.biographyLbl.text = person.biography
        } else {
            self.biographySectionView.isHidden = true
        }
    }
    
    private func renderBornSectionView() {
        if let text = person.birthday,
           text.isEmpty == false {
            self.bornLbl.text = text
            self.bornSectionView.isHidden = false
        } else {
            self.bornSectionView.isHidden = true
        }
    }
    
}

extension CreditsDetailViewController {
    @IBAction func backButtonTouchUpInside(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreButtonTouchUpInside(_ sender: Any) {
        self.biographyLbl.numberOfLines = 0
        self.moreButtonSectionView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension CreditsDetailViewController: UIScrollViewDelegate {
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
