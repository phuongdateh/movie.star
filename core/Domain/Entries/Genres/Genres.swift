//
//  Genres.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation

struct Genres: Decodable {
    let genres: [Genre]
    
    struct Genre: Decodable {
        let id: Int
        let name: String
    }
}
