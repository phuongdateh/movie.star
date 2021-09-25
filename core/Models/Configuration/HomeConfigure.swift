//
//  HomeConfigure.swift
//  core
//
//  Created by Doan Duy Phuong on 25/09/2021.
//

import Foundation

struct HomeConfigure: Decodable {
    let isActive: Bool
    let type: String
    let name: String
    
//    func toMovieSectionItem() -> HomeMovieSectionItem {
//        guard let type = HomeType(rawValue: self.type) else {
//            fatalError()
//        }
//        return .init(title: <#T##String#>, movies: <#T##[Movie]#>)
//    }
    
    enum HomeType: String {
        case popular = "popular"
        case topRated = "top_rated"
        case upComing = "upcoming"
        case nowPlaying = "nowplaying"
    }
}
