//
//  UITableView.swift
//  core
//
//  Created by phuong.doan on 7/4/21.
//

import Foundation
import UIKit

extension UITableViewCell: Reusable { }

extension UITableView {
    func dequeueReusableCell<T>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID,
                                             for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}

