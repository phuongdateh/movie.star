//
//  UIStoryBoard.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit

extension UIStoryboard {
    func instantiateViewController<T>(ofType type: T.Type = T.self) -> T where T: UIViewController {
        guard let viewController = instantiateViewController(withIdentifier: type.reuseID) as? T else {
            fatalError()
        }
        return viewController
    }
}
