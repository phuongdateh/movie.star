//
//  MovieResponse.swift
//  core
//
//  Created by phuong.doand on 10/09/2021.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let totalPages: Int
    let totalReults: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalReults = "total_results"
        case movies = "results"
    }
}
