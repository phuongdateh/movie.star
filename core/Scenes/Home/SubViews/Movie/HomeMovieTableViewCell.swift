//
//  HomeMovieTableViewCell.swift
//  core
//
//  Created by Doan Duy Phuong on 24/09/2021.
//

import UIKit

protocol HomeMovieTableViewCellDelegate: AnyObject {
    func homeMovieTableViewCellDidSelectItem(_ view: HomeMovieTableViewCell,
                                             movieId: Int)
    func homeMovieTableViewCellDidSelectViewAll(_ view: HomeMovieTableViewCell,
                                                item: HomeMovieSectionItem)
}

class HomeMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleSectionbl: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!
    
    weak var delegate: HomeMovieTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }
    
    private func configureView() {
        viewAllButton.setTitle("View All", for: .normal)
        viewAllButton.titleLabel?.font = UIFont(name: AppFont.medium.name, size: 14)
        viewAllButton.tintColor = UIColor.gray

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
    private var item: HomeMovieSectionItem!
    
    func configure(item: HomeMovieSectionItem) {
        self.item = item
        self.titleSectionbl.text = item.title
        self.movies.append(contentsOf: item.movies)
        self.collectionView.reloadData()
    }
    
    @IBAction func viewAllButtonTouchUpInside(_ sender: UIButton) {
        self.delegate?.homeMovieTableViewCellDidSelectViewAll(self, item: self.item)
    }
}

extension HomeMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: MovieCollectionViewCell.self, at: indexPath)
        cell.configure(self.movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.row]
        delegate?.homeMovieTableViewCellDidSelectItem(self, movieId: movie.id)
    }
}

extension HomeMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.collectionView.frame.height)
    }
}
