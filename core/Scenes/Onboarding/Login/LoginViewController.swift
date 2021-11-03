//
//  LoginViewController.swift
//  core
//
//  Created by Doan Duy Phuong on 23/10/2021.
//

import UIKit
import SkyFloatingLabelTextField

enum LoginType {
    case signUp
    case signIn
}

class LoginViewController: ViewController<LoginViewModel> {

    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            self.signUpButton.titleLabel?.font = UIFont(name: AppFont.semiBold.name, size: 12)
            self.signUpButton.tintColor = ColorPalette.orange
            self.signUpButton.setTitle(self.type == .signIn ? "SignUp" : "Log in", for: .normal)
        }
    }

    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            self.loginButton.layer.cornerRadius = 5
            self.loginButton.titleLabel?.font = UIFont(name: AppFont.semiBold.name, size: 16)
        }
    }

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var emailTextField: SkyFloatingLabelTextField = {
        return self.createTextField(with: "Email")
    }()

    private lazy var passwordTextField: SkyFloatingLabelTextField = {
        return self.createTextField(with: "Password")
    }()
    @IBOutlet weak var subtitleLbl: UILabel! {
        didSet {
            self.subtitleLbl.text = self.type == .signUp ? "Already have an account?" : "Don't have an account?"
        }
    }
    
    var type: LoginType!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.type == .signIn ? "Sign In" : "SignUp"
        self.loginButton.setTitle(self.type == .signIn ? "Log in" : "SignUp", for: .normal)
        self.view.addSubview(self.stackView)
        NSLayoutConstraint.activate([
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30),
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])

        self.stackView.addArrangedSubview(self.emailTextField)
        self.stackView.addArrangedSubview(self.passwordTextField)
        self.addBackButton()
    }

    private func createTextField(with name: String) -> SkyFloatingLabelTextField {
        let textField = SkyFloatingLabelTextField.init(frame: .zero)
        textField.placeholder = name

        textField.lineHeight = 1
        textField.selectedLineHeight = 1

        textField.selectedLineColor = ColorPalette.orange
        textField.lineColor = .white

        textField.font = UIFont(name: AppFont.bold.name, size: 14)
        textField.titleFont = UIFont(name: AppFont.regular.name, size: 12)!

        textField.titleColor = .white
        textField.textColor = .white

        textField.selectedTitleColor = .white

        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return textField
    }

    
    @IBAction func loginButtonTouchUpInside(_ sender: UIButton) {
        guard let emailText = self.emailTextField.text,
              emailText.isEmpty == false,
              let passwordText = self.passwordTextField.text,
              passwordText.isEmpty == false else { return }

        switch self.type {
        case .signUp:
            self.shouldShowLoading(isShow: true)
            self.viewModel.createUser(with: emailText,
                                      password: passwordText,
                                      success: {
                self.shouldShowLoading(isShow: false)
                self.showTabbar()
            }, failure: { _ in
                self.shouldShowLoading(isShow: false)
            })
        case .signIn:
            self.shouldShowLoading(isShow: true)
            self.viewModel.signIn(with: emailText,
                                  password: passwordText,
                                  success: {
                self.shouldShowLoading(isShow: false)
                self.showTabbar()
            }, failure: { error in
                self.shouldShowLoading(isShow: false)
            })
        case .none: break
        }
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
        
    }

    private func showTabbar() {
        self.navigator.show(segue: .tabbar(viewModel: TabbarViewModel.init(apiService: MovieAPIService())),
                            sender: nil,
                            transition: .tabbar(in: Application.shared.window!))
    }
}
