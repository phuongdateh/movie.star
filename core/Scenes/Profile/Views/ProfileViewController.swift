//
//  ProfileViewController.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import UIKit
import StoreKit

class ProfileViewController: ViewController<ProfileViewModel> {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationTitle = "Settings"
        self.view.backgroundColor = ColorPalette.background
        self.tableView.backgroundColor = ColorPalette.background
        self.tableView.registerCell(ofType: ProfileTableViewCell.self)
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: ProfileTableViewCell.self, at: indexPath)
        cell.selectionStyle = .none
        cell.configureData(viewModel.cellForRowAt(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.cellForRowAt(indexPath: indexPath)
        switch item {
        case .myFavoriteList:
            self.navigator.show(segue: .myFavorite, sender: self)
        case .rateApp:
            guard let url = URL(string: "itms-apps://itunes.apple.com/app/id1588668113") else {
                return
            }
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        case .feedback:
            let email = "95doanphuong@gmail.com"
            if let url = URL(string: "mailto:\(email)") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        case .about:
            self.navigator.show(segue: .about, sender: self)
        }
    }
}
