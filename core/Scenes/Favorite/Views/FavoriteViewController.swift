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
        self.addBackButton()
        self.navigationTitle = "My Favorite"
        self.view.backgroundColor = ColorPalette.background
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width: CGFloat = Helpers.screenSize().width / 2
        layout.itemSize = CGSize(width: width - 10, height: width + 80)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        self.collectionView.collectionViewLayout = layout
        self.collectionView.backgroundColor = .clear
        self.collectionView.registerCell(ofType: MovieCollectionViewCell.self)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
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
        cell.configure(viewModel.cellForRowAt(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        self.navigator.show(segue: .movieDetail(moviedId: movie.id),
                            sender: self)
    }
}
