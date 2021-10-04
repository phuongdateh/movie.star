//
//  AppFont.swift
//  Highlands
//
//  Created by Hoa Do Duy on 8/27/20.
//  Copyright © 2020 pyco. All rights reserved.
//

import Foundation
import UIKit

enum AppFont {
    case regular
    case light
    case medium
    case bold
    case extraBold
    case semiBold
    case black
    case thin
    var name: String {
        switch self {
        case .regular:
            return "ProximaNova-Regular"
        case .light:
            return "ProximaNova-Light"
        case .medium:
            return "ProximaNova-Medium"
        case .bold:
            return "ProximaNova-Bold"
        case .extraBold:
            return "ProximaNova-Extrabld"
        case .semiBold:
            return "ProximaNova-SemiBold"
        case .black:
            return "ProximaNova-Black"
        case .thin:
            return "ProximaNova-Thin"
        }
    }
    
    var extensionFile: String {
        switch self {
        case .regular:
            return "otf"
        case .light:
            return "otf"
        case .medium:
            return "ttf"
        case .bold:
            return "otf"
        case .extraBold:
            return "otf"
        case .semiBold:
            return "otf"
        case .black:
            return "otf"
        case .thin:
            return "otf"
        }
    }
    
    func ofSize(_ fontSize: CGFloat) -> UIFont? {
        UIFont(name: self.name, size: fontSize)
    }
    
}

extension UILabel {
    func setFont(appFont: AppFont,
                 size: CGFloat,
                 color: UIColor = .white) {
        self.font = UIFont.init(name: appFont.name,
                                size: size)
        self.textColor = color
    }
}
