//
//  Crew.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

struct Crew: Decodable {
    let id: Int
    let adult: Bool
    let gender: Int
    let knownForDepartment: String?
    let name: String?
    var popularity: Double = 0
    let profilePath: String?
    let department: String?
    var creditId: Int = 0
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case gender
        case knownForDepartment = "known_for_department"
        case name
        case profilePath = "profile_path"
        case department
        case creditId = "credit_id"
        case job
    }
}

extension Crew {
    private func sampleJson() -> String {
        return """
            {
                "adult": false,
                "gender": 2,
                "id": 12890,
                "known_for_department": "Writing",
                "name": "Pete Docter",
                "original_name": "Pete Docter",
                "popularity": 3.841,
                "profile_path": "/xz46mHzo8apkVMxmrkMQvqakOL0.jpg",
                "credit_id": "5f7f9fdbd861af00368755b2",
                "department": "Production",
                "job": "Executive Producer"
            }
            """
    }
}

