//
//  Movie.swift
//  core
//
//  Created by phuong.doand on 10/09/2021.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let originalTitle: String
    let backdropPath: String?
    let posterPath: String?
    let releaseDate: String?
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
