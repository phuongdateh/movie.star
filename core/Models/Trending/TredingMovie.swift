//
//  TredingMovie.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

enum MediaType: String {
    case movie
    case tv
    case person
    case all
}

enum TimeWindow: String {
    case day
    case week
}

struct TrendingMovie: Decodable {
    let id: Int
    let backdropPath: String?
    let genreIds: [Int]?
    let originalLanguage: String?
    let originCountry: [String]?
    var voteAverage: Double = 0
    var voteCount: Int = 0
    let posterPath: String?
    var popularity: Double = 0
    let mediaType: String
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genreIds = "genres_ids"
        case originalLanguage = "original_language"
        case originCountry = "origin_country"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case popularity
        case mediaType = "media_type"
        case overview
    }
}
