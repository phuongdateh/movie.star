//
//  FirebaseService.swift
//  core
//
//  Created by Doan Duy Phuong on 25/09/2021.
//

import Foundation
import FirebaseRemoteConfig

final class FirebaseService {
    static let shared = FirebaseService()
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    init() {
        self.configure()
    }
    
    fileprivate func configure() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 2
        remoteConfig.configSettings = settings
    }
    
    func fetchConfigs(completion: ((MovieConfigure) -> ())?) {
        remoteConfig.fetch { [weak self] status, error in
            guard status == .success else {
                return
            }
            self?.remoteConfig.activate { isSuccess, error in
                guard let configsStr = self?.remoteConfig.configValue(forKey: "configs").stringValue else {
                    return
                }
                do {
                    let config = try JSONDecoder().decode(MovieConfigure.self, from:  configsStr.utf8Encoded)
                    completion?(config)
                } catch {
                    fatalError("Decode Fail: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
