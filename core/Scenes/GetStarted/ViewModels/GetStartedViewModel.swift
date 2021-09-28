//
//  GetStartedViewModel.swift
//  core
//
//  Created by phuong.doan on 7/18/21.
//

import Foundation

class GetStartedViewModel: ViewModel {
    
    let apiService: MovieAPIProtocol
    
    init(apiService: MovieAPIProtocol) {
        self.apiService = apiService
    }
    
    func createTabbarViewModel() -> TabbarViewModel {
        return TabbarViewModel.init(apiService: self.apiService)
    }
}
