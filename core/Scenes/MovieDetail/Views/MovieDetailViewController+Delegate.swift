//
//  MovieDetailViewController+Delegate.swift
//  core
//
//  Created by Doan Duy Phuong on 01/10/2021.
//

import Foundation
import UIKit

extension MovieDetailViewController: CreditsViewDelegate {
    func creditsViewDidSelectCredit(_ view: CreditsView, creditId: Int) {
        self.navigator.show(segue: .creditDetail(id: creditId), sender: self)
    }
}

extension MovieDetailViewController: RecommendationsViewDelegate {
    func recommendationsViewDidSelecteItem(_ view: RecommendationsView, movieId: Int) {
        self.navigator.show(segue: .movieDetail(moviedId: movieId), sender: self)
    }
}
