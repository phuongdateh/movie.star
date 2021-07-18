//
//  NetworkProvider.swift
//  core
//
//  Created by phuong.doan on 7/3/21.
//

import Foundation
import RxSwift

final class NetworkProvider {
    private let baseUrl: String
    private var headers: [String: String]
    private var parameters: [String: Any]
    
    init() {
        baseUrl = "https://api.themoviedb.org/3/"
        headers = [:]
        parameters = ["api_key": Constants.apiKey,
                      "language": Constants.language]
    }
    
    func makeGenresNetwork() -> GenresNetwork {
        let network = Network<Genres>(baseUrl,
                                      headers: headers,
                                      parameters: parameters)
        return GenresNetwork(network: network)
    }
}