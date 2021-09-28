//
//  SplashViewController.swift
//  core
//
//  Created by phuong.doand on 14/09/2021.
//

import UIKit

class SplashViewController: ViewController<SplashViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindViewModel() {
        self.navigator.show(segue: .getstarted(viewModel: viewModel.createGetStartedViewModel()), sender: self)
    }
}
