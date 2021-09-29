//
//  Review.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

struct Review: Decodable {
    let id: String
    let author: String?
    let content: String?
    let authorDetails: ReviewAuthor?
    let createdAt: Date?
    let updatedAt: Date?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case author
        case content
        case authorDetails = "author_details"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case url
    }
}
