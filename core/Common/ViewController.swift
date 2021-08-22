//
//  ViewController.swift
//  core
//
//  Created by phuong.doan on 6/30/21.
//

import UIKit
import RxSwift

class ViewController: UIViewController, Navigatable {
    
    var navigator: Navigator!
    var viewModel: ViewModel?
    
    let disposeBag = DisposeBag()

    
//    init(viewModel: ViewModel?, navigator: Navigator) {
//        self.navigator = navigator
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(nibName: nil, bundle: nil)
//    }
    
    var navigationTitle: String = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        makeUI()
        bindViewModel()
    }
    
    func makeUI() {
        
        updateUI()
    }
    
    func bindViewModel() {
        
    }
    
    func updateUI() {
        
    }

}

