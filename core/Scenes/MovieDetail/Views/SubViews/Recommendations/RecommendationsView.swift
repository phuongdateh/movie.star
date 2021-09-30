//
//  RecommendationsView.swift
//  core
//
//  Created by Doan Duy Phuong on 30/09/2021.
//

import Foundation
import UIKit

final class RecommendationsView: UIView {
    
    class func height() -> CGFloat {
        return 400
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }
    
    private func configureView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 15
        collectionView.collectionViewLayout = layout
        collectionView.registerCell(ofType: RecommendationMovieCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private var movies = [Movie]()
    
    func configureData(_ movies: [Movie]) {
        self.movies.append(contentsOf: movies)
        self.collectionView.reloadData()
    }
}

extension RecommendationsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: RecommendationMovieCollectionViewCell.self, at: indexPath)
        cell.configureData(movie: self.movies[indexPath.row])
        return cell
    }
}

extension RecommendationsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.collectionView.frame.height)
    }
}
