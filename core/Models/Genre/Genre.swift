//
//  Genre.swift
//  core
//
//  Created by Doan Duy Phuong on 25/09/2021.
//

import Foundation

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
