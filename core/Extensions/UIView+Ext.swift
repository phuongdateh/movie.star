//
//  UIView+Ext.swift
//  core
//
//  Created by Doan Duy Phuong on 30/09/2021.
//

import Foundation
import UIKit

extension CALayer {
    func applySketchShadow(color: UIColor = UIColor(203, 203, 203, 1),
                           alpha: Float = 1,
                           x: CGFloat = 0,
                           y: CGFloat = 8,
                           blur: CGFloat = 15,
                           spread: CGFloat = 0) {
        shadowColor = UIColor.white.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func removeSketchShadow() {
        shadowOpacity = 0.0
    }
}

extension UIColor {
    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
}

extension UIView: Reusable {}

extension UIView {
    
    private static func nib<T: UIView>(ofType type: T.Type) -> T? {
        return Bundle.main.loadNibNamed(T.reuseID, owner: nil, options: nil)?.first as? T
    }
    
    static func fromNib() -> Self? {
        return nib(ofType: self)
    }
    
    func addShadow() {
        self.clipsToBounds = false
        layer.applySketchShadow(color: .white,
                                alpha: 0.16,
                                x: 0, y: 1,
                                blur: 6,
                                spread: 0)
    }
}

extension UIView {
    func addChildView(view: UIView,
                      topConstant: CGFloat = 0,
                      leftConstant: CGFloat = 0,
                      bottomConstant: CGFloat = 0,
                      rightConstant: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: topConstant),
            view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: leftConstant),
            view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -rightConstant),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -bottomConstant)
        ])
    }
}
