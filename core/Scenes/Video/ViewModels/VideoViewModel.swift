//
//  VideoViewModel.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import Foundation

class VideoViewModel: ViewModel {
    let apiSerivice: MovieAPIProtocol
    
    init(_ apiSerivice: MovieAPIProtocol) {
        self.apiSerivice = apiSerivice
    }
    
    func prepareData() {
        self.getMovie()
    }
    
    private var currentPage: Int = 1
    
    private func getMovie() {
        apiSerivice.getPopular(page: currentPage) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movieResponse):
                if movieResponse.movies.isEmpty == false {
                    movieResponse.movies.forEach { movie in
                        self.getVideos(of: movie)
                    }
                }
            case let .failure(error):
                print("Get MovieFail: \(error.localizedDescription)")
            }
        }
    }
    
    private func getVideos(of movie: Movie) {
        self.apiSerivice.getViedeos(movie.id) {[weak self] result in
            switch result {
            case let .success(videoResults):
                guard let self = self else { return }
                self.tranformToVideoCategories(movie: movie, videoResults: videoResults)
            case let .failure(error):
                print("Get Videos of: \(movie.originalTitle) fail: \(error.localizedDescription)")
            }
        }
    }
    
    var videos = [VideoCategory]() {
        didSet {
            print("TotalVideos: \(self.videos.count)")
            print("TotalVideosTMDB: \(self.totalVideos)")
            self.didDataChange?()
        }
    }
    
    var didDataChange: (() -> ())?
    
    var totalVideos: Int = 0
    
    private func tranformToVideoCategories(movie: Movie, videoResults: VideoResults) {
        self.totalVideos += videoResults.results.count
        print("TotalVideosTMDB: \(self.totalVideos)")
        if videoResults.results.isEmpty == false {
            videoResults.results.forEach { video in
                self.videos.append(VideoCategory.init(movie: movie, video: video))
            }
        }
    }
}
