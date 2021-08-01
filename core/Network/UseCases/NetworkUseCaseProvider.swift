//
//  NetworkUseCaseProvider.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation

class NetworkUseCaseProvider: IUseCaseProvider {
    private let networkProvider: NetworkProvider
    
    init() {
        self.networkProvider = NetworkProvider()
    }
    
    func makeFetchGenres() -> IGenresUseCase {
        let usecase = NetworkGenresUseCase(network: networkProvider.makeGenresNetwork())
        return usecase
    }
}
