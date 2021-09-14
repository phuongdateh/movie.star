//
//  UIViewController.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit

protocol Reusable {
    static var reuseID: String {get}
}

extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UIViewController: Reusable {}

extension UIViewController {
    class func fromNib<T: UIViewController>(ofType: T.Type) -> T {
        return T.init(nibName: T.reuseID, bundle: nil)
    }
}
