//
//  SplashViewController.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit

class SplashViewController: ViewController<SplashViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func bindViewModel() {
        self.navigator.show(segue: .getstarted(viewModel: viewModel.createGetStartedViewModel()), sender: self)
    }
}
