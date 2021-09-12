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
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
    }
}
