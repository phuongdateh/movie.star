//
//  SplashViewModel.swift
//  core9
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import RxSwift
import RxCocoa

class SplashViewModel: ViewModelType {
    
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
    init(_ usecase: DomainGenresUseCaseProtocol,
         _ navigator: SplashNavigatorProtocol) {
        self.usecase = usecase
        self.navigator = navigator
    }
    
    // MARK: - Properties
    private let usecase: DomainGenresUseCaseProtocol
    private let navigator: SplashNavigatorProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - Transform
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        input.viewWillAppear.flatMapLatest {
            return self.usecase.fetchGenres()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .do(onNext: { objc in
                    print("asdads")
                })
        }
        .asDriver()
        .drive()
        .disposed(by: disposeBag)

        let _ = errorTracker.asDriver()
        return .init(fetching: activityIndicator.asDriver())
    }
}
