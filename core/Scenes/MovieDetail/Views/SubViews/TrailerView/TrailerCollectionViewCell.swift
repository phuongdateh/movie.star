//
//  TrailerCollectionViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 01/10/2021.
//

import UIKit

class TrailerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!

    @IBOutlet weak var playView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.thumbnailImageView.layer.cornerRadius = 5
        self.thumbnailImageView.contentMode = .scaleAspectFill
        self.playView.layer.cornerRadius = playView.frame.height / 2
        self.playView.backgroundColor = 0x222222.color
    }
    
    func configureData(_ video: Video) {
        self.titleLbl.text = video.name
        self.thumbnailImageView.downloadImage(with: .youtube(video.key))
    }
    
    @IBAction func playButtonTouchUpInside(_ sender: Any) {
        print(#function)
    }
}
