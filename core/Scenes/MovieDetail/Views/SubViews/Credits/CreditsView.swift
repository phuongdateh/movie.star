//
//  CreditsView.swift
//  core
//
//  Created by Doan Duy Phuong on 30/09/2021.
//

import UIKit

protocol CreditsViewDelegate: AnyObject {
    func creditsViewDidSelectCredit(_ view: CreditsView, creditId: Int)
}

final class CreditsView: UIView {
    
    private let castCollectionViewheight: CGFloat = 200
    private let crewCollectionViewheight: CGFloat = 120
    
    @IBOutlet weak var castSectionView: UIView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var castCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var crewSectionView: UIView!
    @IBOutlet weak var crewCollectionView: UICollectionView!
    @IBOutlet weak var crewCollectionViewHeightConstraint: NSLayoutConstraint!

    private var credits: Credits!
    weak var delegate: CreditsViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }
    
    private func configureView() {
        self.configureHeight()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: castCollectionViewheight * 2 / 3, height: castCollectionViewheight)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        
        castCollectionView.showsHorizontalScrollIndicator = false
        castCollectionView.collectionViewLayout = layout
        castCollectionView.registerCell(ofType: CreditsCollectionViewCell.self)
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        
        crewCollectionView.showsHorizontalScrollIndicator = false
        crewCollectionView.collectionViewLayout = layout
        crewCollectionView.registerCell(ofType: CreditsCollectionViewCell.self)
        crewCollectionView.delegate = self
        crewCollectionView.dataSource = self
    }

    private func configureHeight() {
        self.castCollectionViewHeightConstraint.constant = self.castCollectionViewheight
        self.crewCollectionViewHeightConstraint.constant = self.castCollectionViewheight
    }

    private var cast = [Cast]()
    private var crew = [Crew]()
    
    func configure(credits: Credits) {
        self.credits = credits
        self.cast = credits.cast.filter({ $0.profilePath != nil })
        self.crew = credits.crew.filter({ $0.profilePath != nil })
        self.didSetCredits()
    }

    private func didSetCredits() {
        self.renderCastSectionView(isShow: !credits.cast.isEmpty)
        self.renderCrewSectionView(isShow: !credits.crew.isEmpty)
    }

    private func renderCastSectionView(isShow: Bool) {
        self.castSectionView.isHidden = !isShow
    }

    private func renderCrewSectionView(isShow: Bool) {
        self.crewSectionView.isHidden = !isShow
    }
}

extension CreditsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.castCollectionView {
            return self.cast.count
        } else {
            return self.crew.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.castCollectionView {
            let cell = collectionView.dequeueReusableCell(ofType: CreditsCollectionViewCell.self, at: indexPath)
            cell.configureData(self.cast[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(ofType: CreditsCollectionViewCell.self, at: indexPath)
            cell.configureData(self.crew[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == castCollectionView {
            self.delegate?.creditsViewDidSelectCredit(self, creditId: self.cast[indexPath.row].id)
        } else {
            self.delegate?.creditsViewDidSelectCredit(self, creditId: self.crew[indexPath.row].id)
        }
    }
}
