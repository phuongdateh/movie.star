//
//  HomeMovieTableViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 24/09/2021.
//

import UIKit

class HomeMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleSectionbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }
    
    private func configureView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        collectionView.collectionViewLayout = layout
        collectionView.registerCell(ofType: MovieCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private var movies = [Movie]()
    
    func configure(item: HomeMovieSectionItem) {
        self.titleSectionbl.text = item.title
        self.movies.append(contentsOf: item.movies)
        self.collectionView.reloadData()
    }
}

extension HomeMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: MovieCollectionViewCell.self, at: indexPath)
        cell.configure(self.movies[indexPath.row])
        return cell
    }
}

extension HomeMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.collectionView.frame.height)
    }
}
