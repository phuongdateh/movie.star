//
//  VideoViewController.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import UIKit
import XCDYouTubeKit
import SnapKit
import AVKit

class VideoViewController: ViewController<VideoViewModel> {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.tintColor = .lightGray
        searchBar.backgroundColor = ColorPalette.strongBlue
        searchBar.barTintColor = ColorPalette.background
        searchBar.setImage(UIImage(named: "search_white_ic"), for: .search, state: .normal)
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .lightGray

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func makeUI() {
        tableView.registerCell(ofType: VideoTableViewCell.self)
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = ColorPalette.background
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = ColorPalette.background
    }
    
    override func bindViewModel() {
        viewModel.prepareData()
        viewModel.didDataChange = {
            self.tableView.reloadData()
        }
    }
}

extension VideoViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        viewModel.filterVideo(by: searchText)
    }
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: VideoTableViewCell.self, at: indexPath)
        cell.selectionStyle = .none
        cell.bind(category: viewModel.cellData(of: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigator.show(segue: .videoPlaying(viewModel: self.viewModel.createVideoPlayingViewModel(viewModel.cellData(of: indexPath))),
                            sender: self,
                            transition: .modal)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
