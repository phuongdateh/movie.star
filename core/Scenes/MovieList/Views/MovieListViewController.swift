//
//  MovieListViewController.swift
//  core
//
//  Created by Doan Duy Phuong on 02/10/2021.
//

import UIKit

class MovieListViewController: ViewController<MovieListViewModel> {

    @IBOutlet weak var titleViewLbl: UILabel!
    @IBOutlet weak var changeLayoutButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var listLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.collectionView.frame.width, height: 200)
        layout.minimumLineSpacing = 15
        return layout
    }
    
    private var gridLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width: CGFloat = Helpers.screenSize().width / 2
        layout.itemSize = CGSize(width: width,
                                 height: width + 80)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }
    
    private var isListingLayout: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changeLayoutButton.setTitle("", for: .normal)
        self.changeLayoutButton.setImage(UIImage(named: isListingLayout ? "list_ic" : "grid_ic"), for: .normal)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.collectionView.frame.width - 30, height: 200)
        layout.minimumLineSpacing = 15
        collectionView.collectionViewLayout = layout
        collectionView.registerCell(ofType: MovieCollectionViewCell.self)
        collectionView.registerCell(ofType: MovieListCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.addRefreshHeader { [weak self] in
            self?.retrieveMovies()
        }
        collectionView.addLoadMoreFooter { [weak self] in
            self?.retrieveMoreMovies()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.backgroundColor = ColorPalette.background
    }
    
    override func bindViewModel() {
        titleViewLbl.text = viewModel.titleView
        guard viewModel.movies == nil else {
            return
        }
        self.retrieveMovies()
    }
    
    private func retrieveMovies() {
        collectionView.headerBeginRefreshing()
        viewModel.retrieveMovies(sucess: { [weak self] in
            self?.collectionView.headerEndRefreshing(completion: nil)
            self?.collectionView.reloadData()
        }, fail: { [weak self] in
            self?.collectionView.headerEndRefreshing(completion: nil)
        })
    }
    
    private func retrieveMoreMovies() {
        collectionView.footerBeginRefreshing()
        viewModel.retrieveMovies(isLoadMore: true, sucess: { [weak self] in
            self?.collectionView.footerEndRefreshing(completion: nil)
            self?.collectionView.reloadData()
        }, fail: { [weak self] in
            self?.collectionView.footerEndRefreshing(completion: nil)
        })
    }

    @IBAction func backButtonTouchUpInside(_ sender: LumiKitBackButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func changeLayoutButtonTouchUpInside(_ sender: Any) {
        self.isListingLayout = !isListingLayout
        self.changeLayoutButton.setImage(UIImage(named: isListingLayout ? "list_ic" : "grid_ic"), for: .normal)
        self.view.isUserInteractionEnabled = false
        self.collectionView.startInteractiveTransition(to: isListingLayout ? listLayout : gridLayout) { a, b in
            print("Layout Success \(a) \(b)")
            self.collectionView.reloadData()
            self.view.isUserInteractionEnabled = true
        }
        self.collectionView.finishInteractiveTransition()
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isListingLayout {
            let cell = collectionView.dequeueReusableCell(ofType: MovieListCollectionViewCell.self, at: indexPath)
            cell.configureMovie(viewModel.cellForItemAt(indexPath: indexPath))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(ofType: MovieCollectionViewCell.self, at: indexPath)
            cell.configureMovie(viewModel.cellForItemAt(indexPath: indexPath))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.viewModel.cellForItemAt(indexPath: indexPath)
        self.navigator.show(segue: .movieDetail(moviedId: movie.id), sender: self)
    }
    
}
