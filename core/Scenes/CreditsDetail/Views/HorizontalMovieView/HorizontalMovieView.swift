//
//  HorizontalMovieView.swift
//  core
//
//  Created by Doan Duy Phuong on 01/10/2021.
//

import Foundation
import UIKit

final class HorizontalMovieView<T: BaseCollectionViewCell>: UIView,
                                                            UICollectionViewDelegate,
                                                            UICollectionViewDataSource,
                                                            UICollectionViewDelegateFlowLayout {
    private let stackView = UIStackView()
    private var collectionView: UICollectionView!
    private let titleLbl = UILabel()
    
    private var movies = [Movie]()
    private var sizeForItem: CGSize = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initCollectionView()
        self.configureView()
        self.layout()
    }
    
    private func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.registerCell(ofType: T.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func layout() {
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 15
        self.addChildView(view: stackView,
                          topConstant: 20,
                          leftConstant: 15,
                          rightConstant: 15)
        stackView.addArrangedSubview(titleLbl)
        stackView.addArrangedSubview(collectionView)
    }
    
    private func configureView() {
        titleLbl.font = UIFont(name: AppFont.bold.name, size: 20)
        titleLbl.textColor = .white
        titleLbl.numberOfLines = 1
    }
    
    func configureMovies(_ movies: [Movie],
                         title: String,
                         sizeForItem: CGSize) {
        self.sizeForItem = sizeForItem
        self.titleLbl.text = title
        self.movies = movies
        self.collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if self.movies.count > 12 {
//            return 12
//        }
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: T.self, at: indexPath)
        cell.configureMovie(self.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.sizeForItem
    }
    
}
