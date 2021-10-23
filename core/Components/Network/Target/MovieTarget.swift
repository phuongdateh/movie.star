//
//  MovieTarget.swift
//  core
//
//  Created by phuong.doand on 10/09/2021.
//

import Foundation
import Moya

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
        case .topRated(pageNumber: _):
            return "/movie/top_rated"
        case .nowPlaying(pageNumber: _):
            return "/movie/now_playing"
        case .upcoming(pageNumber: _):
            return "/movie/upcoming"
        case let .detail(id: movieId):
            return "movie/\(movieId)"
        case let .videos(of: movieId):
            return "movie/\(movieId)/videos"
        case .genre:
            return "/genre/movie/list"
        case .movieWithGenres(pageNumber: _, genreId: _):
            return "/discover/movie"
        case .movieRating(pageNumber: _, movieId: let movieId):
            return "/movie/\(movieId)/reviews"
        case .personDetail(personId: let personId):
            return "/person/\(personId)"
        case .movieTrending(pageNumber: _, mediaType: let mediaType, time: let time):
            return "/trending/\(mediaType.rawValue)/\(time.rawValue)"
        case .personTrending(pageNumber: _, time: let time):
            return "/trending/person/\(time.rawValue)"
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
        case .popular(let pageNumber):
            parameters["page"] = pageNumber
        case .upcoming(let pageNumber):
            parameters["page"] = pageNumber
        case .topRated(let pageNumber):
            parameters["page"] = pageNumber
        case .nowPlaying(let pageNumber):
            parameters["page"] = pageNumber
        case .detail(_):
            parameters["append_to_response"] = "videos,credits,recommendations,reviews"
        case .movieWithGenres(let pageNumber, let genreId):
            parameters["page"] = pageNumber
            parameters["with_genres"] = genreId
            parameters["include_video"] = true
        case .movieRating(let pageNumber, _):
            parameters["page"] = pageNumber
        case .personDetail(_):
            parameters["append_to_response"] = "movie_credits,images,tv_credits"
        case .movieTrending(let pageNumber,_,_):
            parameters["page"] = pageNumber
        case .personTrending(let pageNumber, _):
            parameters["page"] = pageNumber
        case .genre, .videos(_):
            break
        }
        return parameters
    }
    
    var task: Task {
        switch self {
        default:
            return .requestParameters(parameters: parameters,
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
