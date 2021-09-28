//
//  HomeHeaderCell.swift
//  core
//
//  Created by Doan Duy Phuong on 24/09/2021.
//

import Foundation
import UIKit
import FSPagerView

class HomeHeaderCell: UITableViewCell {
    
    @IBOutlet weak var pageView: FSPagerView!
    
    private var viewModel: HomeViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureView()
    }
    
    private func configureView() {
        self.backgroundColor = 0x1D1D1D.color
        
        self.pageView.register(UINib(nibName: "HomeItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeItemCollectionViewCell")
        self.pageView.automaticSlidingInterval = 3
        self.pageView.transformer = FSPagerViewTransformer.init(type: .cubic)
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
}
