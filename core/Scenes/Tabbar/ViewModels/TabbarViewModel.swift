//
//  TabbarViewModel.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import Foundation

class TabbarViewModel: ViewModel {
    
    let apiService: MovieAPIProtocol
    
    init(apiService: MovieAPIProtocol) {
        self.apiService = apiService
    }
    
    func createHomeViewModel() -> HomeViewModel {
        return .init()
    }
    
    func createVideoViewModel() -> VideoViewModel {
        return .init(apiService)
    }
    
    func createProfileViewModel() -> ProfileViewModel {
        return .init()
    }
}
