//
//  FavoriteViewController.swift
//  core
//
//  Created by Doan Duy Phuong on 03/10/2021.
//

import UIKit

class FavoriteViewController: ViewController<FavoriteViewModel> {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationTitle = "My Favorite"
        self.view.backgroundColor = ColorPalette.background
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width: CGFloat = Helpers.screenSize().width / 2
        layout.itemSize = CGSize(width: width, height: width + 50)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.collectionView.collectionViewLayout = layout
        self.collectionView.backgroundColor = .clear
        self.collectionView.registerCell(ofType: MovieCollectionViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

extension FavoriteViewController: UICollectionViewDelegate,
                                  UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: MovieCollectionViewCell.self, at: indexPath)
        return cell
    }
}
