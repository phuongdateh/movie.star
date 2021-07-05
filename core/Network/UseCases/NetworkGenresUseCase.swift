//
//  NetworkGenresUseCase.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import RxSwift


class NetworkGenresUseCase: DomainGenresUseCaseProtocol {
    
    private let network: GenresNetwork
    
    init(network: GenresNetwork) {
        self.network = network
    }
    
    func fetchGenres() -> Observable<Genres> {
        return network.fetchGenres()
    }
}
