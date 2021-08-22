//
//  SplashViewController.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SplashViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel as? SplashViewModel else { return }
        self.navigator.show(segue: .getstarted(viewModel: viewModel.toGetStartedViewModel()), sender: self)
    }
}
