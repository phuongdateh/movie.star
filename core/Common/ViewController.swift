//
//  ViewController.swift
//  core
//
//  Created by phuong.doan on 6/30/21.
//

import UIKit

class ViewController<VM: ViewModel>: UIViewController, Navigatable {
    
    var navigator: Navigator!
    var viewModel: VM!
    
    var navigationTitle: String = "" {
        didSet {
            navigationItem.title = navigationTitle
        }
    }
    
    func set(viewModel: VM, navigator: Navigator) {
        self.viewModel = viewModel
        self.navigator = navigator
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

