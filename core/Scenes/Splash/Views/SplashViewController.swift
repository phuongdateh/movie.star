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
    
    var viewModel: SplashViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
        self.bindings()
    }
    
    private func configUI() {
        
    }
    
    private func bindings() {
        assert(viewModel != nil)
        let viewWillAppear = rx
            .sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = SplashViewModel.Input(viewWillAppear: Driver.merge(viewWillAppear))
        
        let output = viewModel.transform(input: input)
        
        output.fetching.drive(rx.isEditing).disposed(by: disposeBag)
    }
}
