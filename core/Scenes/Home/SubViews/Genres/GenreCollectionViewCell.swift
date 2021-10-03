//
//  GenreCollectionViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 25/09/2021.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 10
        self.nameLbl.textColor = .white
        self.backgroundColor = ColorPalette.strongBlue
    }
    
    func configure(_ genre: Genre) {
        iconImageView.image = UIImage(named: "icon_system_\(genre.id)")
        nameLbl.text = genre.name
    }
}
