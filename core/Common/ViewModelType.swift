//
//  ViewModelType.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

class ViewModel: NSObject {
    let provider: DomainUseCaseProviderProtocol
    
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    
    let error = ErrorTracker()
    let serverError = PublishSubject<Error>()
    
    init(provider: DomainUseCaseProviderProtocol) {
        self.provider = provider
        super.init()
        
    }
    
    deinit {
        logDebug("\(type(of: self)): Deinited")
        logResourcesCount()
    }
}
