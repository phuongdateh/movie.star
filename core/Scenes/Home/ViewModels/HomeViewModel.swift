//
//  HomeViewModel.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import Foundation
import UIKit

typealias Action = (() -> ())

struct HomeMovieSectionItem {
    let title: String
    let movies: [Movie]
}

enum HomeActorSectionItem {
    case popular
}

enum HomeSection: Int, CaseIterable {
    case movieBanner = 0
    case genres
    case ads
    case movieList
    case actorList
}

class HomeViewModel: ViewModel {
    
    let apiSerivice: MovieAPIProtocol
    
    init(_ apiSerivice: MovieAPIProtocol = MovieAPIService()) {
        self.apiSerivice = apiSerivice
    }
    
    private var currentPage: Int = 1
    private var movies = [Movie]()
    private let config = Application.shared.movieConfigure!
    
    var didChangeData: (() -> Void)?
    
    private var movieSectionItems = [HomeMovieSectionItem]() {
        didSet {
            self.didChangeData?()
        }
    }
    private var actorSectionItems = [HomeActorSectionItem]()
    private var genres = [Genre]()
    
    func prepareData() {
        self.apiSerivice.getGenres { result in
            switch result {
            case .success(let response):
                self.genres.append(contentsOf: response.genres)
                self.didChangeData?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        self.config.homeConfig.filter({ $0.isActive }).forEach { config in
            guard let type = HomeConfigure.HomeType(rawValue: config.type) else {
                fatalError()
            }
            switch type {
            case .popular:
                self.apiSerivice.getPopular(page: 1) { result in
                    switch result {
                    case .success(let response):
                        self.movieSectionItems.append(HomeMovieSectionItem.init(title: config.name,
                                                                                movies: response.movies))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .nowPlaying:
                self.apiSerivice.getPopular(page: 1) { result in
                    switch result {
                    case .success(let response):
                        self.movieSectionItems.append(HomeMovieSectionItem.init(title: config.name,
                                                                                movies: response.movies))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .topRated:
                self.apiSerivice.getPopular(page: 1) { result in
                    switch result {
                    case .success(let response):
                        self.movieSectionItems.append(HomeMovieSectionItem.init(title: config.name,
                                                                                movies: response.movies))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .upComing:
                self.apiSerivice.getPopular(page: 1) { result in
                    switch result {
                    case .success(let response):
                        self.movieSectionItems.append(HomeMovieSectionItem.init(title: config.name,
                                                                                movies: response.movies))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func retriveMovies(sucess: Action?,
                       fail: (() -> ())?) {
        apiSerivice.getPopular(page: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies.append(contentsOf: response.movies)
                sucess?()
            case .failure(let error):
                print(error.localizedDescription)
                fail?()
            }
        }
    }
    
    func retriveHomeSections() {
        apiSerivice.getPopular(page: 1) { result in
            
        }
        
        apiSerivice.getPopular(page: 1) { result in
            
        }
    }
}

extension HomeViewModel {
    // HomeViewController & UITableView
    func numberOfSections() -> Int {
        return HomeSection.allCases.count
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if section == HomeSection.movieBanner.rawValue ||
            section == HomeSection.genres.rawValue {
            return 1
        } else if section == HomeSection.ads.rawValue,
                  config.isEnableBannerAds {
            return 1
        } else if section == HomeSection.movieList.rawValue {
            return movieSectionItems.count
        } else if section == HomeSection.actorList.rawValue {
            return actorSectionItems.count
        }
        return 0
    }

    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        if section == HomeSection.movieBanner.rawValue {
            return UIScreen.main.bounds.height * 2 / 3
        } else if section == HomeSection.genres.rawValue {
            return 205
        } else if section == HomeSection.ads.rawValue,
                  config.isEnableBannerAds {
            return 100
        } else if section == HomeSection.movieList.rawValue {
            return 213
        } else if section == HomeSection.actorList.rawValue {
            return 120
        }
        return 0
    }
    
    func cellForRowAtGenre() -> [Genre] {
        return self.genres
    }

    func cellForRowAtMovie(indexPath: IndexPath) -> HomeMovieSectionItem {
        return movieSectionItems[indexPath.row]
    }
    
    func cellForRowActor(at indexPath: IndexPath) -> HomeActorSectionItem {
        return actorSectionItems[indexPath.row]
    }
    
}

extension HomeViewModel {
    // HomeHeaderCell
    func numberOfItemsHeaderView() -> Int {
        return self.movies.count
    }
    
    func cellForRowHeaderView(at index: Int) -> Movie {
        return self.movies[index]
    }
}
