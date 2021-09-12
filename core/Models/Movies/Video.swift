//
//  Video.swift
//  core
//
//  Created by phuong.doand on 12/09/2021.
//

import Foundation

struct Video: Decodable {
    let name: String
    let key: String
    let size: Int
    let publishedAt: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case key
        case size
        case id
        case publishedAt = "published_at"
    }
}
