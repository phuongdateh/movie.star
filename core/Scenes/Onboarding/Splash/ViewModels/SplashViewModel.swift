//
//  SplashViewModel.swift
//  core9
//  Created by phuong.doan on 7/4/21.
//

import Foundation

class SplashViewModel:  ViewModel {
    
    // MARK: - Properties
    private let apiService: MovieAPIProtocol
    
    // MARK: - Init
    init(_ apiService: MovieAPIProtocol) {
        self.apiService = apiService
    }
    
    // MARK: - Methods
    func createGetStartedViewModel() -> GetStartedViewModel {
        return .init(apiService: self.apiService)
    }
}
