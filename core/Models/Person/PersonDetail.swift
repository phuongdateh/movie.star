//
//  PersonDetail.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

struct PersonDetail: Decodable {
    let id: Int
    let alsoKnownAs: [String]?
    let biography: String?
    let birthday: String?
    let deathday: String?
    let gender: Int
    let homepage: String?
    let knownForDepartment: String?
    let name: String?
    let placeOfBirth: String?
    var popularity: Double = 0
    let profilePath: String?
    let movieCredits: MovieCredits?
    let tvCredits: MovieCredits?
    
    enum CodingKeys: String, CodingKey  {
        case id
        case alsoKnownAs = "also_known_as"
        case biography
        case birthday
        case deathday
        case gender
        case homepage
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
        case movieCredits = "movie_credits"
        case tvCredits = "tv_credits"
    }
}

struct MovieCredits: Decodable {
    var cast = [Movie]()
    var crew = [Movie]()
}
