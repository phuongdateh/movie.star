//
//  GetStartedViewModel.swift
//  core
//
//  Created by phuong.doan on 7/18/21.
//

import Foundation
import  RxSwift

class GetStartedViewModel: ViewModel, ViewModelType {
    private let usecase: IGenresUseCase
    
    init(usecase: IGenresUseCase) {
        self.usecase = usecase
    }
    
}

extension GetStartedViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
