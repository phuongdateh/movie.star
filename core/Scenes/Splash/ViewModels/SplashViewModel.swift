//
//  SplashViewModel.swift
//  core9
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import RxSwift
import RxCocoa

class SplashViewModel:  ViewModel, ViewModelType {
    
    struct Input {
        let viewWillAppear: Driver<Void>
    }
    
    struct Output {
        let fetching: Driver<Bool>
//        let createLogin: Driver<Void>
//        let createMainTabbar: Driver<[UIApplication.LaunchOptionsKey: Any]?>
//        let error: Driver<Error>
//        let genres: Driver<Genres>
    }
    
    // MARK: - Init
    init(_ apiService: MovieAPIProtocol) {
        self.apiService = apiService
        self.apiService.getPopular(page: 1).asObservable().subscribe(onNext: { movieResponse in
            print(movieResponse.totalPages)
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: - Properties
    private let apiService: MovieAPIProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - Transform
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let _ = errorTracker.asDriver()
        return .init(fetching: activityIndicator.asDriver())
    }
}
