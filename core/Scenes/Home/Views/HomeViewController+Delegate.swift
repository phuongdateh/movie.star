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
    func homeMovieTableViewCellDidSelectViewAll(_ view: HomeMovieTableViewCell, item: HomeMovieSectionItem) {
        self.navigator.show(segue: .movieList(title: nil, movies: nil, genre: nil, item: item), sender: self)
    }
    
    func homeMovieTableViewCellDidSelectItem(_ view: HomeMovieTableViewCell, movieId: Int) {
        self.pushMovieDetail(movieId)
    }
}

extension HomeViewController {
    private func pushMovieDetail(_ movieId: Int) {
        self.navigator.show(segue: .movieDetail(moviedId: movieId), sender: self)
    }
}

extension HomeViewController: GenresTableViewCellDelegate {
    func genresTableViewCellDidSelectItem(_ view: GenresTableViewCell, genre: Genre) {
        self.navigator.show(segue: .movieList(title: nil, movies: nil, genre: genre, item: nil), sender: self)
    }
}
