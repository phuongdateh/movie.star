//
//  MovieAPIService.swift
//  core
//
//  Created by phuong.doand on 08/09/2021.
//

import Foundation
import Moya

final class MovieAPIService: MovieAPIProtocol {
    var provider: MoyaProvider<MovieApi>
    
    init() {
        self.provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin()])
    }
    
    func getPopular(page: Int = 1, completion: @escaping Completion<MovieResponse>) {
        self.request(target: .popular(pageNumber: page), completion)
    }
}

extension MovieAPIProtocol {
    func request<T: Decodable>(target: MovieApi,_ completion: @escaping Completion<T>) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
