//
//  GetStartedViewController.swift
//  core
//
//  Created by phuong.doan on 7/15/21.
//

import Foundation
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
        self.navigator.show(segue: .tabbar(viewModel: TabbarViewModel.init()), sender: self)
    }
}
