//
//  ColorPalette.swift
//  core
//
//  Created by Doan Duy Phuong on 20/09/2021.
//

import Foundation
import UIKit

struct ColorPalette {
    static var darkBlue: UIColor {
        return 0x0D1139.color
    }
    
    static var mistyBlue: UIColor {
        return 0xC3CEDA.color
    }
    
    static var background: UIColor {
        return 0x101B50.color
    }
    
    static var strongBlue: UIColor {
        return 0x0D1139.color
    }
    
    static var orange: UIColor {
        return 0xE8772F.color
    }
}

extension Int {
    var color: UIColor {
        let red = CGFloat((self & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((self & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat((self & 0x0000FF) >> 0) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
