//
//  ViewModelType.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
