//
//  ProfileTableViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 03/10/2021.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        wrapperView.backgroundColor = ColorPalette.background
        wrapperView.addShadow()
        wrapperView.layer.cornerRadius = 10
        
        iconImageView.tintColor = ColorPalette.orange
    }
    
    func configureData(_ item: ProfileItem) {
        self.titleLbl.text = item.title
        self.iconImageView.image = item.icon
    }
}

enum ProfileItem {
    case myFavoriteList
    case rateApp
    case feedback
    case about

    var title: String {
        switch self {
        case .myFavoriteList:
            return "My Favorite List"
        case .rateApp:
            return "Rate App"
        case .feedback:
            return "Feedback"
        case .about:
            return "About"
        }
    }

    var icon: UIImage?  {
        switch self {
        case .myFavoriteList:
            return UIImage(named: "love_ic")
        case .rateApp:
            return UIImage(named: "rate_ic")
        case .feedback:
            return UIImage(named: "feedback_ic")
        case .about:
            return UIImage(named: "about_ic")
        }
    }
}
