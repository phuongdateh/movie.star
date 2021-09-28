//
//  MovieAPIProtocol.swift
//  core
//
//  Created by phuong.doand on 08/09/2021.
//

import Foundation
import Moya

typealias CompletionResult<T: Decodable> = (Result<T, Error>) -> ()

protocol MovieAPIProtocol {
    var provider: MoyaProvider<MovieTarget> { get set }
    
    func getPopular(page: Int,_ completion: @escaping CompletionResult<MovieResponse>)
    func getTopRated(page: Int,_ completion: @escaping CompletionResult<MovieResponse>)
    func getUpcomming(page: Int,_ completion: @escaping CompletionResult<MovieResponse>)
    func getNowPlaying(page: Int,_ completion: @escaping CompletionResult<MovieResponse>)
    func getMovieDetail(_ movieId: Int,_ comepletion: @escaping CompletionResult<MovieDetail>)
    func getViedeos(_ movieId: Int,_ comepletion: @escaping CompletionResult<VideoResults>)
    func getGenres(_ completion: @escaping CompletionResult<GenreResponse>)
}
 
