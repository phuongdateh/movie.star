//
//  Movie.swift
//  core
//
//  Created by phuong.doand on 10/09/2021.
//

import Foundation
import RealmSwift

struct Movie: Decodable {
    let id: Int
    let title: String?
    let name: String?
    let originalName: String?
    let originalTitle: String?
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
    var voteAverage: Double = 0
    var voteCount: Int = 0
    let character: String?
    let episodeCount: Int?
    let firstAirDate: String?
    let genreIds: [Int]?
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case name
        case originalName = "original_name"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case episodeCount = "episode_count"
        case firstAirDate = "first_air_date"
        case genreIds = "genre_ids"
    }
    
    func favorite() {
        let movie = MovieRealm(id: self.id,
                               title: self.title,
                               posterPath: self.posterPath,
                               backdropPath: self.backdropPath,
                               releaseDate: self.releaseDate)
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
