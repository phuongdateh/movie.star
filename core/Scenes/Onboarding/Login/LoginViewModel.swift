//
//  LoginViewModel.swift
//  core
//
//  Created by Doan Duy Phuong on 23/10/2021.
//

import Foundation

class LoginViewModel: ViewModel {
    let authService: AuthenticationService = AuthenticationService.default

    func createUser(with email: String,
                    password: String,
                    success: @escaping () -> Void,
                    failure: @escaping (Error) -> Void) {
        print("Create User with: \(email) & \(password)")
        self.authService.signUp(with: email,
                                password: password) { authResult in
            success()
        } failure: { error in
            failure(error)
        }
    }

    func signIn(with email: String,
                password: String,
                success: @escaping () -> Void,
                failure: @escaping (Error) -> Void) {
        self.authService.sigIn(with: email, password: password) { authResult in
            success()
        } failure: { error in
            failure(error)
        }
    }
}
