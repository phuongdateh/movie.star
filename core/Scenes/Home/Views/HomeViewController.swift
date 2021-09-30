//
//  HomeViewController.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import UIKit

class HomeViewController: ViewController<HomeViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func makeUI() {
        self.registerCells()
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.backgroundColor = ColorPalette.background
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.backgroundColor = ColorPalette.background
    }
    
    private func registerCells() {
        tableView.registerCell(ofType: HomeHeaderCell.self)
        tableView.registerCell(ofType: HomeMovieTableViewCell.self)
        tableView.registerCell(ofType: NativeAdsTableViewCell.self)
        tableView.registerCell(ofType: GenresTableViewCell.self)
    }
    
    override func bindViewModel() {
        viewModel.didChangeData = {[weak self] in
            self?.updateView()
        }
        viewModel.prepareData()
    }
    
    private func updateView() {
        self.tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == HomeSection.movieBanner.rawValue {
            let cell = tableView.dequeueReusableCell(ofType: HomeHeaderCell.self, at: indexPath)
            cell.selectionStyle = .none
            cell.delegate = self
            cell.setViewModel(viewModel: self.viewModel)
            return cell
        } else if section == HomeSection.genres.rawValue {
            let cell = tableView.dequeueReusableCell(ofType: GenresTableViewCell.self, at: indexPath)
            cell.selectionStyle = .none
            cell.configure(viewModel.cellForRowAtGenre())
            return cell
        } else if section == HomeSection.ads.rawValue {
            let cell = tableView.dequeueReusableCell(ofType: NativeAdsTableViewCell.self, at: indexPath)
            return cell
        } else if section == HomeSection.movieList.rawValue {
            let cell = tableView.dequeueReusableCell(ofType: HomeMovieTableViewCell.self, at: indexPath)
            cell.selectionStyle = .none
            cell.delegate = self
            cell.configure(item: viewModel.cellForRowAtMovie(indexPath: indexPath))
            return cell
        } else if section == HomeSection.actorList.rawValue {
            
        }
        return .init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
}
