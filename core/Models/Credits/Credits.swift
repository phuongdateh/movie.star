//
//  Credits.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation

struct CreditsResponse: Decodable {
    let creadit: Credits
}

struct Credits: Decodable {
    let cast: [Cast]?
    let crew: [Crew]?
}
