//
//  HomeViewController+Delegate.swift
//  core
//
//  Created by Doan Duy Phuong on 28/09/2021.
//

import Foundation
import UIKit

// MARK: - HomeHeaderCell
extension HomeViewController: HomeHeaderCellDelegate {
    func homeHeaderCellDidSelectItem(view: HomeHeaderCell, moviedId: Int) {
        self.pushMovieDetail(moviedId)
    }
}

// MARK: - HomeMovieTableViewCell
extension HomeViewController: HomeMovieTableViewCellDelegate {
    func homeMovieTableViewCellDidSelectItem(_ view: HomeMovieTableViewCell, movieId: Int) {
        self.pushMovieDetail(movieId)
    }
}

extension HomeViewController {
    private func pushMovieDetail(_ movieId: Int) {
        self.navigator.show(segue: .movieDetail(moviedId: movieId), sender: self)
    }
}
