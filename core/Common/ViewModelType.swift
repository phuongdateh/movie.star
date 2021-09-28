//
//  ViewModelType.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation

class ViewModel: NSObject {
    
    var isLoading: Bool = false
    
    override init() {
        super.init()
        
    }
    
    deinit {
        print("\(type(of: self)): Deinited")
    }
}
