//
//  TrailerView.swift
//  core
//
//  Created by Doan Duy Phuong on 01/10/2021.
//

import UIKit

protocol TrailerViewDelegate: AnyObject {
    func trailerViewDidSelectItem(_ view: TrailerView, _ video: Video)
}

class TrailerView: UIView {
    
    static var height: CGFloat {
        return  230
    }

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: TrailerViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }
    
    private func configureView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        collectionView.collectionViewLayout = layout
        collectionView.registerCell(ofType: TrailerCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private var videos = [Video]()
    
    func configureData(videos: [Video]) {
        self.videos = videos
        self.collectionView.reloadData()
    }
}
extension TrailerView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: TrailerCollectionViewCell.self, at: indexPath)
        cell.configureData(self.videos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let video = self.videos[indexPath.row]
        self.delegate?.trailerViewDidSelectItem(self, video)
    }
}

extension TrailerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: self.collectionView.frame.height)
    }
}
