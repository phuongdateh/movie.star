//
//  SplashViewModel.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import RxSwift

class SplashViewModel: ViewModelType {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    // MARK: - Init
    init(_ usecase: DomainGenresUseCaseProtocol,_ navigator: SplashNavigatorProtocol) {
        self.usecase = usecase
        self.navigator = navigator
    }
    
    // MARK: - Properties
    private let usecase: DomainGenresUseCaseProtocol
    private let navigator: SplashNavigatorProtocol
    
    // MARK: - Transform
    func transform(input: Input) -> Output {
        
        return Output()
    }
}
