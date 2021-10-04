//
//  UITableView.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(ofType cellType: T.Type) {
        self.register(UINib(nibName: T.reuseID, bundle: nil), forCellReuseIdentifier: T.reuseID)
    }
    
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID,
                                             for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(ofType cellType: T.Type) {
        self.register(UINib(nibName: T.reuseID, bundle: nil), forCellWithReuseIdentifier: T.reuseID)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(ofType cellType: T.Type,
                                                      at indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}

