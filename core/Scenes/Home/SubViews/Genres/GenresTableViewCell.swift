//
//  GenresTableViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 25/09/2021.
//

import UIKit

class GenresTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var genres: [Genre]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureView()
    }

    private func configureView() {
        collectionView.registerCell(ofType: GenreCollectionViewCell.self)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 150,
                                 height: 80)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundView?.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(_ genres: [Genre]) {
        self.genres = genres
        collectionView.reloadData()
    }
}

extension GenresTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard self.genres != nil else {
            return 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: GenreCollectionViewCell.self, at: indexPath)
        cell.configure(self.genres[indexPath.row])
        return cell
    }
}
