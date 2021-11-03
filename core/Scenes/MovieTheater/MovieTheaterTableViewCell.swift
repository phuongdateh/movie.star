//
//  MovieTheaterTableViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 03/11/2021.
//

import UIKit

class MovieTheaterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var directionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.wrapperView.layer.cornerRadius = 5
        self.wrapperView.addShadow()

        self.directionButton.layer.cornerRadius = 5
    }

    private var data: MovieTheaterResult?
    func configure(data: MovieTheaterResult?) {
        self.data = data
        self.nameLbl.text = self.data?.name
        self.addressLbl.text = self.data?.vicinity
        self.photoImageView.retrieveMovieTheater(path: self.data?.photos.first?.photo_reference ?? "")
    }

    @IBAction func directionButtonTouchUpInside(_ sender: UIButton) {
        
    }
}
