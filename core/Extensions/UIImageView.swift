//
//  UIImageView.swift
//  core
//
//  Created by phuong.doand on 14/09/2021.
//

import Foundation
import UIKit
import SDWebImage

enum SourceImage {
    case youtube(String)
    case tmdb(String)
}

extension UIImageView {
    func downloadImage(with source: SourceImage) {
        switch source {
        case let .youtube(videoId):
            self.sd_setImage(with: URL(string: "https://img.youtube.com/vi/\(videoId)/sddefault.jpg"), placeholderImage: UIImage(named: "placeholder_ic"))
        case let .tmdb(path):
            self.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(path)"), placeholderImage: UIImage(named: "placeholder_ic"))
        }
    }
    
    func retrivingImage(path: String) {
        self.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(path)"), placeholderImage: UIImage(named: "placeholder_ic"))
    }
}
