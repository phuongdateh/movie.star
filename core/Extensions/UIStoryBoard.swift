//
//  UIStoryBoard.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type = T.self, viewModel: ViewModel, navigator: Navigator) -> T where T: ViewController {
        guard let viewController = instantiateViewController(withIdentifier: type.reuseID) as? T else {
            fatalError()
        }
        viewController.viewModel = viewModel
        viewController.navigator = navigator
        return viewController
    }
}
