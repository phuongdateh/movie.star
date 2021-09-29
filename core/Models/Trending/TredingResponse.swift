//
//  TredingResponse.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

enum MediaType: String {
    case movie
    case tv
    case person
    case all
}

enum TimeWindow: String {
    case day
    case week
}

struct TrendingResponse<T: Decodable>: Decodable {
    let page: Int
    let totalPages: Int
    let totalReults: Int
    let results: [T]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalReults = "total_results"
        case results
    }
}
