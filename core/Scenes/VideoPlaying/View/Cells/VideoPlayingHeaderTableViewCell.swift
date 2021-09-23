//
//  VideoPlayingHeaderTableViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 20/09/2021.
//

import UIKit

class VideoPlayingHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subinfoLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    var updateAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        seeMoreButton.titleLabel?.font = UIFont(name: AppFont.regular.name, size: 12)
        seeMoreButton.tintColor = UIColor.gray
    }
    
    func binds(source: YoutubeVideo,
               isSeeMore: Bool) {
        descriptionLbl.numberOfLines = isSeeMore ? 0 : 3
        seeMoreButton.isHidden = isSeeMore
        self.titleLbl.text = source.video.title
        let subinfoStr = NSMutableAttributedString()
        subinfoStr.append(NSAttributedString(string: source.video.author + " - ",
                                             attributes: [.font: UIFont(name: AppFont.regular.name, size: 12)!, .foregroundColor: UIColor.gray]))
        subinfoStr.append(NSAttributedString(string: "\(source.video.viewCount) views", attributes: [.font: UIFont(name: AppFont.regular.name, size: 12)!, .foregroundColor: UIColor.gray]))
        subinfoLbl.attributedText = subinfoStr
        
        descriptionLbl.text = source.video.videoDescription
    }
    
    @IBAction func seeMoreButton_TouchUpInside(_ sender: UIButton) {
        updateAction?()
    }
}
