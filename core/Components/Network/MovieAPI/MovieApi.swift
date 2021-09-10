//
//  MovieApi.swift
//  core
//
//  Created by phuong.doand on 10/09/2021.
//

import Foundation
import Moya

enum MovieApi {
    case popular(pageNumber: Int)
    case upcoming
    case topRated
    case nowPlaying
}

extension MovieApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Configs.Network.baseURL) else {
            fatalError("URL invalid")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .popular(pageNumber: _):
            return "/movie/popular"
        default: return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    var parameters: [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["api_key"] = Configs.Network.apiKey
        parameters["language"] = Configs.Network.language
        switch self {
        case let .popular(pageNumber: number):
            parameters["page"] = number
        default: return [:]
        }
        return parameters
    }
    
    var task: Task {
        switch self {
        default:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
