//
//  CastCollectionViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 30/09/2021.
//

import UIKit

class CreditsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarProfileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.avatarProfileImageView.layer.cornerRadius = 5
        self.avatarProfileImageView.contentMode = .scaleAspectFill
        self.nameLbl.numberOfLines = 2
    }

    func configureData(_ creditData: CreditsDisplayable) {
        self.avatarProfileImageView.retrivingImage(path: creditData.profilePathUrl)
        self.nameLbl.text = creditData.nameDisplay
    }
}
