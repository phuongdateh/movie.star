//
//  MovieDetail.swift
//  core
//
//  Created by phuong.doand on 12/09/2021.
//

import Foundation

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
    }
}
