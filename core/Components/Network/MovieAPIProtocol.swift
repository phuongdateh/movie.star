//
//  MovieAPIProtocol.swift
//  core
//
//  Created by phuong.doand on 08/09/2021.
//

import Foundation
import Moya
import RxSwift

protocol MovieAPIProtocol {
    var provider: MoyaProvider<MovieApi> { get set }
    
    func getPopular(page: Int) -> Single<MovieResponse>
}
