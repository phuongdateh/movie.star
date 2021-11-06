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

    func shouldFetchData() -> Bool {
        return theaters.isEmpty
    }

    func retrieveNearMovieTheater(success: (() -> Void)?,
                                  failure: (() -> Void)?) {
        self.apiService.getNearMovieTheater(pageToken: nil,
                                            completion: { [weak self] result in
            switch result {
            case .success(let response):
                print("Success: \(response.results)")
                self?.theaters = response.results
                success?()
            case .failure(let error):
                print("RetrieveNearMovieTheater: \(error.localizedDescription)")
                failure?()
            }
        })
    }

    private var theaters = [MovieTheaterResult]()

    func numberOfRows() -> Int {
        return self.theaters.count
    }

    func cellData(indexPath: IndexPath) -> MovieTheaterResult {
        return theaters[indexPath.row]
    }
}
