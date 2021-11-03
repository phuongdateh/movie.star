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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: VideoTableViewCell.self, at: indexPath)
        cell.selectionStyle = .none
        cell.bind(category: viewModel.videos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigator.show(segue: .videoPlaying(viewModel: self.viewModel.createVideoPlayingViewModel(viewModel.videos[indexPath.row])),
                            sender: self,
                            transition: .modal)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
