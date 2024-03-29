//
//  MovieListViewModel.swift
//  core
//
//  Created by Doan Duy Phuong on 02/10/2021.
//

import Foundation

final class MovieListViewModel: ViewModel {
    var movies: [Movie]?
    let genre: Genre?
    let item: HomeMovieSectionItem?
    private let title: String?
    
    private let service: MovieAPIProtocol
    private let config: MovieConfigure
    
    init(movies: [Movie]?,
         title: String?,
         genre: Genre?,
         item: HomeMovieSectionItem?,
         apiService: MovieAPIProtocol = MovieAPIService(),
         config: MovieConfigure = Application.shared.movieConfigure!) {
        self.movies = movies
        self.genre = genre
        self.item = item
        self.service = apiService
        self.config = config
        self.title = title
    }
    
    var titleView: String {
        if let title = self.title {
            return title
        } else if let genre = genre {
            return genre.name
        } else if let item = item {
            return item.title
        } else {
            return ""
        }
    }
    
    private var currentPage: Int = 1
    private var totalPages: Int = 0
    
    func retrieveMovies(isLoadMore: Bool = false,
                        sucess: Action?,
                        fail: (() -> ())?) {
        if isLoadMore {
            guard currentPage < totalPages else {
                return
            }
            currentPage += 1
        }
        if let genre = genre {
            self.service.getMovieWithGenre(page: currentPage, genreId: genre.id) { [weak self] result in
                self?.handleResponseResults(isLoadMore, sucess, fail, result)
            }
        } else if let item = item {
            switch item.homeType {
            case .nowPlaying:
                self.service.getNowPlaying(page: currentPage) { [weak self] result in
                    self?.handleResponseResults(isLoadMore, sucess, fail, result)
                }
            case .popular:
                self.service.getPopular(page: currentPage) { [weak self] result in
                    self?.handleResponseResults(isLoadMore, sucess, fail, result)
                }
            case .topRated:
                self.service.getTopRated(page: currentPage) { [weak self] result in
                    self?.handleResponseResults(isLoadMore, sucess, fail, result)
                }
            case .upComing:
                self.service.getUpcomming(page: currentPage) { [weak self] result in
                    self?.handleResponseResults(isLoadMore, sucess, fail, result)
                }
            }
        } else {
            fail?()
        }
    }

    func handleResponseResults(_ isLoadMore: Bool,
                               _ sucess: Action?,
                               _ fail: (() -> ())?,
                               _ result: Result<ResultsResponse<Movie>, Error>) {
        switch result {
        case let .success(response):
            self.totalPages = response.totalPages
            if isLoadMore {
                self.movies?.append(contentsOf: response.results)
            } else {
                self.movies = response.results
            }
            sucess?()
        case let .failure(err):
            print(err.localizedDescription)
            fail?()
       }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func cellForItemAt(indexPath: IndexPath) -> Movie {
        guard let movies = movies else {
            fatalError("Movie List Nil")
        }
        return movies[indexPath.row]
    }
}
