//
//  MovieAPIService.swift
//  core
//
//  Created by phuong.doand on 08/09/2021.
//

import Foundation
import Moya
import RxSwift

final class MovieAPIService: MovieAPIProtocol {
    var provider: MoyaProvider<MovieApi>
    
    init() {
        self.provider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(), VerbosePlugin(verbose: true)])
    }
    
    func getPopular(page: Int) -> Single<MovieResponse> {
        return self.request(target: .popular(pageNumber: page), type: MovieResponse.self)
    }
}

extension MovieAPIProtocol {
    func request<T: Decodable>(target: MovieApi, type: T.Type) -> Single<T>{
        return provider.rx
            .request(target)
            .filterSuccessfulStatusAndRedirectCodes()
            .map(T.self)
    }
}
