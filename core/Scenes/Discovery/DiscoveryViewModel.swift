//
//	DiscoveryViewModel.swift
//	core
//
//	Created by Doan Duy Phuong on 07/11/2021.
//	
//	

import Foundation

class DiscoveryViewModel: ViewModel {
    private let apiService: MovieAPIProtocol

    init(apiService: MovieAPIProtocol = MovieAPIService()) {
        self.apiService = apiService
    }

    private var currentPage: Int = 1
    private var movies = [Movie]()

    func retrieveMovies(by keyword: String,
                        success: (() -> Void)?,
                        failure: (() -> Void)?) {
        apiService.searchMovie(query: keyword,
                               page: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response.results
                success?()
            case .failure(let error):
                print("\(#function) \(error.localizedDescription)")
                failure?()
            }
        }
    }

    func numberOfRows() -> Int {
        return movies.count
    }

    func cellData(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
}
