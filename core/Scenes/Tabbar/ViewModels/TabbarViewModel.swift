//
//  TabbarViewModel.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import Foundation

class TabbarViewModel: ViewModel {
    
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
