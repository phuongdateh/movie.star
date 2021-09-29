//
//  RatingView.swift
//  core
//
//  Created by Doan Duy Phuong on 29/09/2021.
//

import Foundation
import Cosmos

final class RatingView: CosmosView {
    
    var newSettings = CosmosSettings()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configuration()
    }
    
    private func configuration() {
        newSettings.totalStars = 5
        newSettings.fillMode = .precise
        newSettings.disablePanGestures = true
        newSettings.starSize = 16
        newSettings.filledBorderWidth = 1
        newSettings.filledImage = UIImage.init(named: "rating_filled_ic")?.withRenderingMode(.alwaysOriginal)
        newSettings.emptyImage = UIImage.init(named: "rating_empty_ic")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.white)
        self.settings = newSettings
    }
}
