//
//  Application.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit

final class Application {
    static let shared = Application()
    
    private let apiService: MovieAPIProtocol?
    private let navigator: Navigator
    
    var window: UIWindow?
    
    init() {
        self.apiService = MovieAPIService.init()
        self.navigator = Navigator.default
    }
    
    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window, let apisevice = apiService else {
            return
        }
        self.window = window
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {[weak self] in
            let viewModel = SplashViewModel(apisevice)
            self?.navigator.show(segue: .splash(viewModel), sender: nil, transition: .root(in: window))
        })
    }
}
