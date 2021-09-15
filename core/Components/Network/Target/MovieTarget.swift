//
//  MovieTarget.swift
//  core
//
//  Created by phuong.doand on 10/09/2021.
//

import Foundation
import Moya

enum MovieTarget {
    case popular(pageNumber: Int)
    case upcoming
    case topRated
    case nowPlaying
    case detail(id: Int)
    case videos(of: Int)
}

extension MovieTarget: TargetType {
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
        case let .detail(id: movieId):
            return "movie/\(movieId)"
        case let .videos(of: movieId):
            return "movie/\(movieId)/videos"
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
        if case let .popular(pageNumber: number) = self {
            parameters["page"] = number
        } else if case .detail(id: _) = self {
            parameters["append_to_response"] = "videos,images"
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
