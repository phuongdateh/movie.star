//
//  TabbarViewModel.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import Foundation
import RxSwift
import RxCocoa

class TabbarViewModel: ViewModel, ViewModelType {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        return .init()
    }
    
    func createHomeViewModel() -> HomeViewModel {
        return .init()
    }
    
    func createVideoViewModel() -> VideoViewModel {
        return .init()
    }
    
    func createProfileViewModel() -> ProfileViewModel {
        return .init()
    }
}