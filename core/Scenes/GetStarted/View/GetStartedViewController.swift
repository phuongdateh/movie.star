//
//  GetStartedViewController.swift
//  core
//
//  Created by phuong.doan on 7/15/21.
//

import Foundation
import RxSwift
import RxCocoa

class GetStartedViewController: ViewController {
    
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func bindViewModel() {
        guard let viewModel = self.viewModel as? GetStartedViewModel else { return }
        self.getStartedButton.rx.tap.subscribe(onNext: {[unowned self] in
            self.navigator.show(segue: .tabbar(viewModel: TabbarViewModel.init()), sender: self)
        }).disposed(by: disposeBag)
    }
}
