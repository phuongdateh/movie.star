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
    init(_ usecase: IUseCaseProvider) {
        self.usecase = usecase
        
    }
    
    // MARK: - Properties
    private let usecase: IUseCaseProvider
    private let disposeBag = DisposeBag()
    
    // MARK: - Transform
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let _ = errorTracker.asDriver()
        return .init(fetching: activityIndicator.asDriver())
    }
    
    // MARK: - Methods
    func toGetStartedViewModel() -> GetStartedViewModel {
        return GetStartedViewModel(usecase: usecase.makeFetchGenres())
    }
}
