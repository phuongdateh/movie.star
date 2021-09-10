//
//  MovieAPIService.swift
//  core
//
//  Created by phuong.doand on 08/09/2021.
//

import Foundation
import Moya

final class MovieAPIService: MovieAPIProtocol {
    var provier: MoyaProvider<MovieApi>
    
    init() {
        self.provier = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin()])
    }
    
    func getPopular(completion: @escaping Completion<MovieResponse>) {
        
    }
}
