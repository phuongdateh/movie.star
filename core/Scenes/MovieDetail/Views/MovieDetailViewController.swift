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
        self.posterImageView.downloadImage(with: .tmdb("/2CAL2433ZeIihfX1Hb2139CX0pW.jpg"))
        
        self.thumbnailImageView.contentMode = .scaleAspectFill
        self.thumbnailImageView.layer.cornerRadius = 5
        self.thumbnailImageView.downloadImage(with: .tmdb("/zZTy8G3sEVZNv0yGssgc7DvPUQJ.jpg"))
    }

    @IBAction func backButtonTouchUpInside(_ sender: LumiKitBackButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func playButtonTouchUpInside(_ sender: PlayButton) {
        print(#function)
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
