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
        
        nameLbl.textColor = .white
    }
    
    func configure(_ genre: Genre) {
        iconImageView.image = UIImage(named: "icon_system_\(genre.id)")
        nameLbl.text = genre.name
    }
}
