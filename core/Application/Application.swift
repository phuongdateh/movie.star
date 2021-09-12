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
        guard let window = window, let _ = apiService else {
            return
        }
        self.window = window
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {[weak self] in
            if let self = self {
                if self.isLauchedApp {
                    self.showTabbar()
                } else {
                    self.setAppLauched()
                    self.showGetStarted()
                }
            }
        })
    }
    
    private func showGetStarted() {
        let viewModel = SplashViewModel(self.apiService!)
        self.navigator.show(segue: .splash(viewModel), sender: nil, transition: .root(in: window!))
    }
    
    private func showTabbar() {
        self.navigator.show(segue: .tabbar(viewModel: TabbarViewModel.init()), sender: nil, transition: .tabbar(in: window!))
    }
    
    private func setAppLauched() {
        UserDefaults.standard.setValue(true, forKey: "isLauchedApp")
        UserDefaults.standard.synchronize()
    }
    
    private var isLauchedApp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLauchedApp")
        }
    }
}
