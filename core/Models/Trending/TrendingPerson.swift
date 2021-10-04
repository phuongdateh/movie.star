//
//  TrendingPerson.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

struct TrendingPerson: Decodable {
    let id: Int
    let name: String?
    let gender: Int
    let profilePath: String?
    let knownForDepartment: String?
    let movies: TrendingMovies?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case profilePath = "profile_path"
        case knownForDepartment = "known_for_department"
        case movies = "known_for"
    }
}

struct TrendingMovies: Decodable {
    let movies: [TrendingMovie]

    enum CodingKeys: String, CodingKey {
        case movies = "known_for"
    }
}
