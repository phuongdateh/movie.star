//
//  MovieAPIService.swift
//  core
//
//  Created by phuong.doand on 08/09/2021.
//

import Foundation
import Moya

final class MovieAPIService: MovieAPIProtocol {
    
    var provider: MoyaProvider<MovieTarget>
    
    init() {
        self.provider = MoyaProvider<MovieTarget>(plugins: [NetworkLoggerPlugin(), VerbosePlugin(verbose: true)])
    }
    
    func getPopular(page: Int, _ completion: @escaping CompletionResult<MovieResponse>) {
        self.request(target: .popular(pageNumber: page), completion)
    }
    
    func getMovieDetail(_ movieId: Int, _ completion: @escaping CompletionResult<MovieDetail>) {
        self.request(target: .detail(id: movieId), completion)
    }
    
    func getViedeos(_ movieId: Int, _ completion: @escaping CompletionResult<VideoResults>) {
        self.request(target: .videos(of: movieId), completion)
    }
}

extension MovieAPIProtocol {
    func request<T: Decodable>(target: MovieTarget,_ completion: @escaping CompletionResult<T>) {
        self.provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
