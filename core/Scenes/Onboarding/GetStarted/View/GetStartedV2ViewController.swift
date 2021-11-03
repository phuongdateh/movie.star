//
//  GetStartedV2ViewController.swift
//  core
//
//  Created by Doan Duy Phuong on 23/10/2021.
//

import UIKit

class GetStartedV2ViewController: ViewController<GetStartedViewModel> {
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.skipButton.layer.cornerRadius = 5
        self.loginButton.layer.cornerRadius = 5
        self.signUpButton.layer.cornerRadius = 5
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    @IBAction func skipButtonAction(_ sender: UIButton) {
        self.navigator.show(segue: .tabbar(viewModel: self.viewModel.createTabbarViewModel()),
                            sender: nil,
                            transition: .tabbar(in: Application.shared.window!))
    }

    @IBAction func loginButtonAction(_ sender: UIButton) {
        self.navigator.show(segue: .login(.signIn), sender: self)
    }

    @IBAction func signUpButtonAction(_ sender: UIButton) {
        self.navigator.show(segue: .login(.signUp), sender: self)
    }
}
