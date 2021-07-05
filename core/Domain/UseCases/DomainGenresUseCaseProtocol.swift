//
//  GenresUseCase.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import RxSwift

protocol DomainGenresUseCaseProtocol {
    func fetchGenres() -> Observable<Genres>
}
