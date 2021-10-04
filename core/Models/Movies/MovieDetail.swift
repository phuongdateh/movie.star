//
//  MovieDetail.swift
//  core
//
//  Created by phuong.doand on 12/09/2021.
//

import Foundation
import RealmSwift

struct MovieDetail: Decodable {
    let id: Int
    let runtime: Int
    let videos: VideoResults?
    let backdropPath: String?
    let title: String?
    let status: String?
    let tagline: String?
    var voteAverage: Double = 0
    var voteCount: Int = 0
    let releaseDate: String?
    let posterPath: String?
    let overview: String?
    let originalTitle: String?
    let homepage: String?
    let genres: [Genre]?
    let recommendations: ResultsResponse<Movie>?
    let reviews: ResultsResponse<Review>?
    let credits: Credits?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.runtime = try container.decode(Int.self, forKey: .runtime)
        self.videos = try? container.decode(VideoResults.self, forKey: .videos)
        self.backdropPath = try? container.decode(String.self, forKey: .backdropPath)
        self.title = try? container.decode(String.self, forKey: .title)
        self.status = try? container.decode(String.self, forKey: .status)
        self.tagline = try? container.decode(String.self, forKey: .tagline)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        self.posterPath = try? container.decode(String.self, forKey: .posterPath)
        self.genres = try? container.decode([Genre].self, forKey: .genres)
        self.reviews = try? container.decode(ResultsResponse<Review>.self, forKey: .reviews)
        self.credits = try? container.decode(Credits.self, forKey: .credits)
        self.recommendations = try? container.decode(ResultsResponse<Movie>.self, forKey: .recommendations)
        self.homepage = try? container.decode(String.self, forKey: .homepage)
        self.originalTitle = try? container.decode(String.self, forKey: .originalTitle)
        self.overview = try? container.decode(String.self, forKey: .overview)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case runtime
        case videos
        case title
        case backdropPath = "backdrop_path"
        case status
        case voteAverage = "vote_average"
        case tagline
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case overview
        case originalTitle = "original_title"
        case homepage
        case genres = "genres"
        case recommendations
        case reviews
        case credits
    }
    
    func favorite() {
        let movie = MovieRealm(id: self.id,
                               title: self.title,
                               posterPath: self.posterPath,
                               backdropPath: self.backdropPath,
                               releaseDate: self.releaseDate,
                               voteAverage: self.voteAverage)
        let realm = try! Realm()
        realm.safeWrite {
            realm.add(movie, update: .all)
        }
    }
    
    func isFavorite() -> Bool {
        let realm = try! Realm()
        return realm.objects(MovieRealm.self).map({ $0.id }).contains(self.id)
    }
}
