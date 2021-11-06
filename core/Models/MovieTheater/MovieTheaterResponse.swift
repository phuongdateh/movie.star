//
//  MovieTheaterResponse.swift
//  core
//
//  Created by Doan Duy Phuong on 03/11/2021.
//

import Foundation

struct MovieTheaterResponse: Decodable {
    let status: String?
    let results: [MovieTheaterResult]
    let next_page_token: String?
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
    let photos: [Photo]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        geometry = try? container.decode(Geometry.self, forKey: .geometry)
        icon = try? container.decode(String.self, forKey: .icon)
        icon_mask_base_uri = try? container.decode(String.self, forKey: .icon_mask_base_uri)
        name = try? container.decode(String.self, forKey: .name)
        place_id = try? container.decode(String.self, forKey: .place_id)
        user_ratings_total = try? container.decode(Int.self, forKey: .user_ratings_total)
        rating = try? container.decode(Double.self, forKey: .rating)
        vicinity = try? container.decode(String.self, forKey: .vicinity)
        photos = (try? container.decode([Photo].self, forKey: .photos)) ?? [Photo]()
    }

    enum CodingKeys: String,
                     CodingKey {
        case geometry
        case icon
        case icon_mask_base_uri
        case name
        case place_id
        case user_ratings_total
        case rating
        case vicinity
        case photos
    }
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
