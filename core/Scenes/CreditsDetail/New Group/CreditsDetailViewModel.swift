//
//  CreditsDetailViewModel.swift
//  core
//
//  Created by Doan Duy Phuong on 01/10/2021.
//

import Foundation

final class CreditsDetailViewModel: ViewModel {
    private let id: Int
    private let apiService: MovieAPIProtocol
    private var personDetail: PersonDetail?
    private let config: MovieConfigure
    
    init(id: Int,
         apiService: MovieAPIProtocol = MovieAPIService(),
         config: MovieConfigure = Application.shared.movieConfigure!) {
        self.apiService = apiService
        self.id = id
        self.config = config
    }
    
    func isShouldShowAdsView() -> Bool {
        return config.isEnableNativeAds
    }
    
    func retrievePersonDetail(success: @escaping (() -> Void),
                             error: @escaping ((String) -> ())) {
        self.apiService.getPersonDetail(self.id) { [weak self] result in
            switch result {
            case .success(let detail):
                print("Person detail: \(detail)")
                self?.personDetail = detail
                success()
            case .failure(let err):
                print(err.localizedDescription)
                error(err.localizedDescription)
            }
        }
    }
    
    func getPersonDetail() -> PersonDetail? {
        return self.personDetail
    }
}
