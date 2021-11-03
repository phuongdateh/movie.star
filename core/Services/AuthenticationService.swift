//
//  AuthenticationService.swift
//  core
//
//  Created by Doan Duy Phuong on 23/10/2021.
//

import Foundation
import FirebaseAuth

final class AuthenticationService {
    static let `default` = AuthenticationService()

    func signUp(with email: String,
                password: String,
                success: @escaping ((AuthDataResult) -> Void),
                failure: @escaping (Error) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password,
                               completion: { authResult, error in
            guard let result = authResult else {
                guard let error = error else {
                    return
                }
                print(error.localizedDescription)
                failure(error)
                return
            }
            success(result)
        })
    }

    func sigIn(with email: String,
               password: String,
               success: @escaping ((AuthDataResult) -> Void),
               failure: @escaping (Error) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password,
                           completion: { authResult, error in
            guard let result = authResult else {
                guard let error = error else {
                    return
                }
                print(error.localizedDescription)
                failure(error)
                return
            }
            success(result)
        })
    }
}
