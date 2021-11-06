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

    func retrieveNearMovieTheater(success: (() -> Void)?,
                                  failure: (() -> Void)?) {
        self.apiService.getNearMovieTheater(pageToken: nil,
                                            completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.nextPageToken = response.next_page_token
                self?.theaters = response.results
                success?()
            case .failure(let error):
                print("RetrieveNearMovieTheater: \(error.localizedDescription)")
                failure?()
            }
        })
    }

    func retrieveMore(success: (() -> Void)?,
                      failure: (() -> Void)?) {
        guard nextPageToken != nil else {
            failure?()
            return
        }
        self.apiService.getNearMovieTheater(pageToken: nil,
                                                    completion: { [weak self] result in
            switch result {
            case .success(let response):
                self?.nextPageToken = response.next_page_token
                self?.theaters.append(contentsOf: response.results)
                success?()
            case .failure(let error):
                print("RetrieveNearMovieTheater: \(error.localizedDescription)")
                failure?()
            }
        })
    }

    private var nextPageToken: String?
    private var theaters = [MovieTheaterResult]()

    func numberOfRows() -> Int {
        return self.theaters.count
    }

    func cellData(indexPath: IndexPath) -> MovieTheaterResult {
        return theaters[indexPath.row]
    }
}
