//
//  Crew.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

struct Crew: Decodable {
    let id: Int
    let gender: Int
    let knownForDepartment: String?
    let name: String?
    var popularity: Double = 0
    let profilePath: String?
    let department: String?
    let creditId: String?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case gender
        case knownForDepartment = "known_for_department"
        case name
        case profilePath = "profile_path"
        case department
        case creditId = "credit_id"
        case job
    }
}
