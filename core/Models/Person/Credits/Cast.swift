//
//  Cast.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

struct Cast: Decodable {
    let id: Int
    let gender: Int
    let knownForDepartment: String?
    let name: String?
    var popularity: Double = 0
    let profilePath: String?
    var castId: Int = 0
    let character: String?
    let creditId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case gender
        case knownForDepartment = "known_for_department"
        case name
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
    }
}

let sampleJson = """
{
    "adult": false,
    "gender": 2,
    "id": 1277188,
    "known_for_department": "Acting",
    "name": "Jacob Tremblay",
    "original_name": "Jacob Tremblay",
    "popularity": 11.717,
    "profile_path": "/ngQAfH1GuKhnMSOQNm9zo7aWiqO.jpg",
    "cast_id": 9,
    "character": "Luca Paguro (voice)",
    "credit_id": "6037b03e11c0660040492809",
    "order": 0
}
"""
