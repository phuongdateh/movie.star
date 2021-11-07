//
//	DiscoveryViewController.swift
//	core
//
//	Created by Doan Duy Phuong on 07/11/2021.
//	
//	

import UIKit

class DiscoveryViewController: ViewController<DiscoveryViewModel> {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationTitle = "Search"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width: CGFloat = Helpers.screenSize().width / 2
        layout.itemSize = CGSize(width: width,
                                 height: width + 80)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.registerCell(ofType: MovieCollectionViewCell.self)
        collectionView.keyboardDismissMode = .onDrag
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self

        searchBar.delegate = self
        searchBar.tintColor = .lightGray
        searchBar.backgroundColor = ColorPalette.strongBlue
        searchBar.barTintColor = ColorPalette.background
        searchBar.setImage(UIImage(named: "search_white_ic"), for: .search, state: .normal)
        searchBar.placeholder = "Search films on TMDb"
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.textColor = .lightGray
            searchBar.searchTextField.font = UIFont(name: AppFont.medium.name, size: 14)
        } else {
            let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = .lightGray
            textFieldInsideSearchBar?.font = UIFont(name: AppFont.medium.name, size: 14)
        }

        view.backgroundColor = ColorPalette.background
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

extension DiscoveryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        viewModel.retrieveMovies(by: searchText,
                                 success: { [weak self] in
            self?.collectionView.reloadData()
        }, failure: {
            print("ZFailure")
        })
    }
}

extension DiscoveryViewController: UICollectionViewDelegate,
                                   UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofType: MovieCollectionViewCell.self, at: indexPath)
        cell.configure(viewModel.cellData(at: indexPath))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        navigator.show(segue: .movieDetail(moviedId: viewModel.cellData(at: indexPath).id), sender: self)
    }
}
