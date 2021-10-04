//
//  LumiKitBackButton.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation
import UIKit

final class LumiKitBackButton: UIControl {

    private let kHeight: CGFloat = 40
    private let kImageHeight: CGFloat = 25

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubViews()
    }

    private func initSubViews() {
        frame = CGRect.init(origin: frame.origin,
                            size: CGSize.init(width: kHeight, height: kHeight)
        )

        backgroundColor = .clear

        // container view with offset
        let radius: CGFloat = kHeight / 2

        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topRight, .bottomRight],
                                cornerRadii: CGSize(width: radius, height: radius))

        let containerView = UIView.init(frame: bounds)
        containerView.backgroundColor =  ColorPalette.strongBlue
        containerView.isUserInteractionEnabled = false
        self.addSubview(containerView)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        containerView.layer.mask = mask

        let imageView = UIImageView.init(frame: bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.white
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.init(named: "back_ic")
        self.addSubview(imageView)

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: kHeight),
            self.heightAnchor.constraint(equalToConstant: kHeight),
            imageView.widthAnchor.constraint(equalToConstant: kImageHeight),
            imageView.heightAnchor.constraint(equalToConstant: kImageHeight),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.shadowPath = path.cgPath
        shapeLayer.shadowRadius = 5
        shapeLayer.shadowOpacity = 1
        shapeLayer.shadowColor = UIColor.gray.cgColor

//        self.layer.insertSublayer(shapeLayer, below: containerView.layer)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        initSubViews()
    }
}
