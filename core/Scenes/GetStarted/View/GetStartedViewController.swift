//
//  GetStartedViewController.swift
//  core
//
//  Created by phuong.doand on 14/09/2021.
//

import UIKit

class GetStartedViewController: ViewController<GetStartedViewModel> {
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func bindViewModel() {
        
        
    }
    @IBAction func getStartedButtonAction(_ sender: UIButton) {
        self.navigator.show(segue: .tabbar(viewModel: self.viewModel.createTabbarViewModel()), sender: self)
    }
}
