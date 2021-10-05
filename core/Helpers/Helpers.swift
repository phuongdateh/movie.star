//
//  Helpers.swift
//  core
//
//  Created by Doan Duy Phuong on 28/09/2021.
//

import Foundation
import UIKit

final class Helpers {
    class func screenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    class func setAppLauched() {
        UserDefaults.standard.setValue(true, forKey: "isLauchedApp")
        UserDefaults.standard.synchronize()
    }
    
    static var isLauchedApp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLauchedApp")
        }
    }
}
