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
        self.tableView.tableFooterView = UIView()
        self.tableView.tableHeaderView = UIView()
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
            print("")
        case .rateApp:
            print("")
            guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
                return
            }
            if #available(iOS 14.0, *) {
                SKStoreReviewController.requestReview(in: windowScene)
            } else if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
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
            print("")
        }
    }
}
