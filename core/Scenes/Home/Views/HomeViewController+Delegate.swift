//
//  HomeViewController+Delegate.swift
//  core
//
//  Created by Doan Duy Phuong on 28/09/2021.
//

import Foundation
import UIKit

// MARK: - HomeHeaderCell
extension HomeViewController: HomeHeaderCellDelegate {
    func homeHeaderCellDidSelectItem(view: HomeHeaderCell, moviedId: Int) {
        self.navigator.show(segue: .movieDetail(moviedId: moviedId), sender: self)
    }
}
