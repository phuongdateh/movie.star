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
    
    private let topStackView = UIStackView()
    private let viewAllSectionView = UIView()
    private let viewAllLabel = UILabel()
    private let titleLbl = UILabel()
    
    private var collectionView: UICollectionView!
    
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
        self.topStackView.addArrangedSubview(titleLbl)
        self.topStackView.addArrangedSubview(viewAllSectionView)
        self.viewAllSectionView.addSubview(viewAllLabel)
        viewAllLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewAllLabel.topAnchor.constraint(equalTo: viewAllSectionView.topAnchor),
            viewAllLabel.rightAnchor.constraint(equalTo: viewAllSectionView.rightAnchor,
                                                constant: -15),
            viewAllLabel.bottomAnchor.constraint(equalTo: viewAllSectionView.bottomAnchor)
        ])
        self.addChildView(view: stackView,
                          topConstant: 20,
                          leftConstant: 15,
                          rightConstant: 15)
        stackView.addArrangedSubview(self.topStackView)
        stackView.addArrangedSubview(collectionView)
    }
    
    @objc private func viewAllButtonTouchUpInside() {
        print(#function)
    }

    private func configureView() {
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 15

        topStackView.axis = .horizontal
        topStackView.spacing = 0
        topStackView.alignment = .fill

        viewAllLabel.text = "View All"
        viewAllLabel.font = UIFont(name: AppFont.medium.name, size: 14)
        viewAllLabel.textColor = .lightGray

        viewAllSectionView.isUserInteractionEnabled = true
        viewAllSectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HorizontalMovieView.viewAllButtonTouchUpInside)))

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
