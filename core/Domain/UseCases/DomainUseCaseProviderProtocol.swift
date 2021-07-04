//
//  UseCaseProvider.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation

protocol DomainUseCaseProviderProtocol {
    func makeFetchGenres() -> DomainGenresUseCaseProtocol
}
