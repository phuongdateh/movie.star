//
//  VideoViewModel.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import Foundation

class VideoViewModel: ViewModel {
    let apiSerivice: MovieAPIProtocol
    
    init(_ apiSerivice: MovieAPIProtocol) {
        self.apiSerivice = apiSerivice
    }
    
    
}
