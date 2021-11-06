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
        wrapperView.layer.cornerRadius = 5
        wrapperView.addShadow()

        directionButton.layer.cornerRadius = 5
        photoImageView.layer.cornerRadius = 5
        photoImageView.contentMode = .scaleAspectFill
    }

    private var data: MovieTheaterResult?
    func configure(data: MovieTheaterResult?) {
        self.data = data
        ratingView.rating = data?.rating ?? 0
        ratingView.alpha = data?.rating != nil ? 1 : 0
        nameLbl.text = self.data?.name
        addressLbl.text = self.data?.vicinity
        photoImageView.retrieveMovieTheater(path: self.data?.photos.first?.photo_reference ?? "")
    }

    @IBAction func directionButtonTouchUpInside(_ sender: UIButton) {
        let location = data?.geometry?.location
        Helpers.openGoogleMapsFor(lat: location?.lat ?? 0,
                                  lng: location?.lng ?? 0,
                                  address: data?.vicinity ?? "")
    }
}
