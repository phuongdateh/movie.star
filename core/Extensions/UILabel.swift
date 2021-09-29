//
//  UILabel.swift
//  core
//
//  Created by Doan Duy Phuong on 30/09/2021.
//

import Foundation
import UIKit

extension UILabel {
    func lineCount() -> Int {
        let oldNumberOfLines = self.numberOfLines
        self.numberOfLines = 0
        let textSize = CGSize.init(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let rHeight = lroundf(Float(sizeThatFits(textSize).height))
        let charSize = lroundf(Float(font.lineHeight))
        let bonusRHeight = charSize/2
        let lineCount = (rHeight + bonusRHeight)/charSize
        self.numberOfLines = oldNumberOfLines
        return lineCount
    }
}
