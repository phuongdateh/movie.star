//
//  ReviewAuthor.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

struct ReviewAuthor: Decodable {
    let name: String?
    let username: String?
    let avatarPath: String?
    var rating: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
}
