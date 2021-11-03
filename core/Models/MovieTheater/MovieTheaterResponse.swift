//
//  MovieTheaterResponse.swift
//  core
//
//  Created by Doan Duy Phuong on 03/11/2021.
//

import Foundation

struct MovieTheaterResponse: Decodable {
    let status: String
    let results: [MovieTheaterResult]
}

struct MovieTheaterResult: Decodable {
    let geometry: Geometry?
    let icon: String?
    let icon_mask_base_uri: String?
    let name: String?
    let place_id: String?
    let user_ratings_total: Int?
    let rating: Double?
    let vicinity: String?
    var photos = [Photo]()
}

struct Location: Decodable {
    var lat: Double = 0
    var lng: Double = 0
}

struct Geometry: Decodable {
    let location: Location?
}

struct Photo: Decodable {
    let photo_reference: String?
}
