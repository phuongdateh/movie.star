//
//  MovieAPIProtocol.swift
//  core
//
//  Created by phuong.doand on 08/09/2021.
//

import Foundation
import Moya

typealias Completion<T: Decodable> = (Result<T, Error>) -> ()

protocol MovieAPIProtocol {
    var provider: MoyaProvider<MovieApi> { get set }
    
    func getPopular(page: Int, completion: @escaping Completion<MovieResponse>)
}
