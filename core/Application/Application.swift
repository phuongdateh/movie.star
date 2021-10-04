//
//  Application.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit
import Firebase
import RealmSwift

final class Application {
    static let shared = Application()
    
    private let apiService: MovieAPIProtocol?
    private let navigator: Navigator
    var movieConfigure: MovieConfigure?
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
        self.setupFirebase()
        self.setupRealm()
        
        FirebaseService.shared.fetchConfigs { [weak self] config in
            self?.movieConfigure = config
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                if self.isLauchedApp {
                    self.showTabbar()
                } else {
                    self.setAppLauched()
                    self.showGetStarted()
                }
            }
        }
    }
    
    private func showGetStarted() {
        let viewModel = SplashViewModel(self.apiService!)
        self.navigator.show(segue: .splash(viewModel), sender: nil, transition: .root(in: window!))
    }
    
    private func showTabbar() {
        let viewModel = TabbarViewModel(apiService: self.apiService!)
        self.navigator.show(segue: .tabbar(viewModel: viewModel), sender: nil, transition: .tabbar(in: window!))
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

extension Application {
    fileprivate func setupFirebase() {
        FirebaseApp.configure()
    }
    
    fileprivate func setupRealm() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 0,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                print("Migration Realm")
                
            }
        )
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        _ = try! Realm()
    }
}
