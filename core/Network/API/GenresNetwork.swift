//
//  GenresNetwork.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import RxSwift

class GenresNetwork {
    private let network: Network<Genres>
    
    init(network: Network<Genres>) {
        self.network = network
    }
    
    func fetchGenres() -> Observable<Genres> {
        return network.getItem("genre/movie/list")
    }
}
 
