//
//  HomeItemCollectionViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 23/09/2021.
//

import UIKit
import FSPagerView

class HomeItemCollectionViewCell: FSPagerViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.contentMode = .scaleAspectFill
        
        wrapperView.layer.cornerRadius = 20
    }
    
    func configure(_ movie: Movie) {
        posterImageView.retrivingImage(path: movie.posterPath ?? "")
        titleLbl.text = movie.originalTitle
    }

}
