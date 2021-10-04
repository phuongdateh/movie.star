//
//  HomeHeaderCell.swift
//  core
//
//  Created by Doan Duy Phuong on 24/09/2021.
//

import Foundation
import UIKit
import FSPagerView

protocol HomeHeaderCellDelegate: AnyObject {
    func homeHeaderCellDidSelectItem(view: HomeHeaderCell,
                                     moviedId: Int)
}

class HomeHeaderCell: UITableViewCell {
    
    @IBOutlet weak var pageView: FSPagerView!
    
    private var viewModel: HomeViewModel!
    weak var delegate: HomeHeaderCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureView()
    }

    private func configureView() {
        self.backgroundColor = ColorPalette.background
        
        self.pageView.register(UINib(nibName: "HomeItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeItemCollectionViewCell")
        self.pageView.automaticSlidingInterval = 3
        self.pageView.transformer = FSPagerViewTransformer.init(type: .overlap)
        self.pageView.delegate = self
        self.pageView.dataSource = self
    }
    
    func setViewModel(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        viewModel.retriveMovies(sucess: { [weak self] in
            self?.updateView()
        }, fail: {
            
        })
    }

    private func updateView() {
        self.pageView.reloadData()
    }
}

extension HomeHeaderCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return viewModel.numberOfItemsHeaderView()
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HomeItemCollectionViewCell", at: index) as! HomeItemCollectionViewCell
        cell.configure(viewModel.cellForRowHeaderView(at: index))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let movieItem = self.viewModel.cellForRowHeaderView(at: index)
        self.delegate?.homeHeaderCellDidSelectItem(view: self,
                                                   moviedId: movieItem.id)
    }
}
