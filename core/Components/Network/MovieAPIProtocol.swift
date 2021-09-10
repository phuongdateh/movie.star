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
    var provier: MoyaProvider<MovieApi> { get set }
    
    func getPopular(completion: @escaping Completion<MovieResponse>)
}

extension MovieAPIProtocol {
    private func request<T: Decodable>(target: MovieApi, completion: @escaping Completion<T>) {
        self.provier.request(target) { <#Result<Response, MoyaError>#> in
            <#code#>
        }
    }
}
