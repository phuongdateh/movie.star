//
//  ReviewResponse.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

struct ReviewsResponse: Decodable {
    let page: Int
    let totalPages: Int
    let totalReults: Int
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalReults = "total_results"
        case reviews = "results"
    }
}
