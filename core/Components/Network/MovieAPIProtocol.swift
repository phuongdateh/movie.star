//
//  MovieAPIProtocol.swift
//  core
//
//  Created by phuong.doand on 08/09/2021.
//

import Foundation
import Moya

typealias CompletionResult<T: Decodable> = (Result<T, Error>) -> ()

enum MovieTarget {
    case popular(pageNumber: Int)
    case upcoming(pageNumber: Int)
    case topRated(pageNumber: Int)
    case nowPlaying(pageNumber: Int)
    case detail(id: Int)
    case videos(of: Int)
    case movieWithGenres(pageNumber: Int,
                         genreId: Int)
    case movieRating(pageNumber: Int,
                     movieId: Int)
    case personDetail(personId: Int)
    case movieTrending(pageNumber: Int,
                       mediaType: MediaType,
                       time: TimeWindow)
    case personTrending(pageNumber: Int,
                        time: TimeWindow)
    case genre
    case movieTheater
}

protocol MovieAPIProtocol {
    var provider: MoyaProvider<MovieTarget> { get set }
    
    func getPopular(page: Int,
                    _ completion: @escaping CompletionResult<ResultsResponse<Movie>>)
    func getTopRated(page: Int,
                     _ completion: @escaping CompletionResult<ResultsResponse<Movie>>)
    func getUpcomming(page: Int,
                      _ completion: @escaping CompletionResult<ResultsResponse<Movie>>)
    func getNowPlaying(page: Int,
                       _ completion: @escaping CompletionResult<ResultsResponse<Movie>>)
    
    func getMovieWithGenre(page: Int,
                           genreId: Int,
                           completion: @escaping CompletionResult<ResultsResponse<Movie>>)

    func getMovieRating(page: Int,
                        movieId: Int,
                        completion: @escaping CompletionResult<ResultsResponse<Review>>)
    func getMovieDetail(_ movieId: Int,
                        _ comepletion: @escaping CompletionResult<MovieDetail>)
    func getViedeos(_ movieId: Int,
                    _ comepletion: @escaping CompletionResult<VideoResults>)
    func getGenres(_ completion: @escaping CompletionResult<GenreResponse>)

    func getPersonDetail(_ personId: Int,
                         _ completion: @escaping CompletionResult<PersonDetail>)
    func getMovieTrending(page: Int,
                          mediaType: MediaType,
                          time: TimeWindow,
                          completion: @escaping CompletionResult<ResultsResponse<TrendingMovie>>)
    func getPersonTrending(page: Int,
                           time: TimeWindow,
                           completion: @escaping CompletionResult<ResultsResponse<TrendingPerson>>)
    func getNearMovieTheater(completion: @escaping CompletionResult<MovieTheaterResponse>)
}
 
