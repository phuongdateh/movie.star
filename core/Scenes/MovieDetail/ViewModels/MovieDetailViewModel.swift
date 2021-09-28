//
//  MovieDetailViewModel.swift
//  core
//
//  Created by Doan Duy Phuong on 28/09/2021.
//

import Foundation

final class MovieDetailViewModel: ViewModel {
    let id: Int
    let apiService: MovieAPIProtocol
    
    init(movieId: Int,
         apiService: MovieAPIProtocol = MovieAPIService()) {
        self.apiService = apiService
        self.id = movieId
    }
}
