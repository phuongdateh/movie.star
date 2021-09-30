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

extension Cast: CreditsDisplayable {
    var nameDisplay: String {
        return self.name ?? ""
    }
    
    var profilePathUrl: String {
        return self.profilePath ?? ""
    }
}
