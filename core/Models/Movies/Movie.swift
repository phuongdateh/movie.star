//
//  Movie.swift
//  core
//
//  Created by phuong.doand on 10/09/2021.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String?
    let originalTitle: String?
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
    var voteAverage: Double = 0
    var voteCount: Int = 0
    let character: String?
    let episodeCount: Int?
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case episodeCount = "episode_count"
    }
}
