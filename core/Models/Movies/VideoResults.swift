//
//  VideoResults.swift
//  core
//
//  Created by phuong.doand on 12/09/2021.
//

import Foundation

struct VideoResults: Decodable {
    let id: Int?
    let results: [Video]
}
