//
//  MovieTheaterViewModel.swift
//  core
//
//  Created by Doan Duy Phuong on 03/11/2021.
//

import Foundation

class MovieTheaterViewModel: ViewModel {
    private let apiService: MovieAPIProtocol

    init(apiService: MovieAPIProtocol = MovieAPIService()) {
        self.apiService = apiService
    }

    func retrieveNearMovieTheater() {
        self.apiService.getNearMovieTheater(pageToken: nil,
                                            completion: { result in
            switch result {
            case .success(let response):
                print("Success: \(response.results)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
