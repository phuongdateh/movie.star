//
//  MovieDetailViewModel.swift
//  core
//
//  Created by Doan Duy Phuong on 28/09/2021.
//

import Foundation

final class MovieDetailViewModel: ViewModel {
    private let id: Int
    private let apiService: MovieAPIProtocol
    private var movieDetail: MovieDetail?
    private let config: MovieConfigure
    
    init(movieId: Int,
         apiService: MovieAPIProtocol = MovieAPIService(),
         config: MovieConfigure = Application.shared.movieConfigure!) {
        self.apiService = apiService
        self.id = movieId
        self.config = config
    }
    
    func isShouldShowAdsView() -> Bool {
        return config.isEnableNativeAds
    }
    
    func retrieveMovieDetail(success: @escaping (() -> Void),
                             error: @escaping ((String) -> ())) {
        self.apiService.getMovieDetail(self.id) { [weak self] result in
            switch result {
            case .success(let detail):
                self?.movieDetail = detail
                success()
            case .failure(let err):
                print("❌ Movie detail fail")
                error(err.localizedDescription)
            }
        }
    }
    
    func getMovieDetail() -> MovieDetail? {
        return self.movieDetail
    }
}
