//
//  UIScrollView.swift
//  core
//
//  Created by Doan Duy Phuong on 03/10/2021.
//

import Foundation
import UIKit
import MJRefresh

extension UIScrollView {
    func addRefreshHeader(_ refreshAction: @escaping ()->()) {
        let headerForLoading = MJRefreshNormalHeader {
            refreshAction()
        }
        headerForLoading.loadingView?.color = .lightGray
        headerForLoading.lastUpdatedTimeLabel?.isHidden = true
        headerForLoading.stateLabel?.isHidden = true
        mj_header = headerForLoading
        
    }
    
    func addLoadMoreFooter(_ loadMoreAction: @escaping ()->()) {
        let footerForLoading = MJRefreshAutoNormalFooter {
            loadMoreAction()
        }
        footerForLoading.loadingView?.color = .lightGray
        footerForLoading.isRefreshingTitleHidden = true
        footerForLoading.stateLabel?.isHidden = true
        mj_footer = footerForLoading
    }
    
    func headerBeginRefreshing() {
        mj_header?.beginRefreshing()
    }
    
    func headerEndRefreshing(completion: (()->())? = nil) {
        if let completion = completion {
            mj_header?.endRefreshing(completionBlock: completion)
        }
        else {
            mj_header?.endRefreshing()
        }
    }
    
    func footerBeginRefreshing() {
        mj_footer?.beginRefreshing()
    }
    
    func footerEndRefreshing(completion: (()->())? = nil) {
        if let mj_footer = mj_footer {
            mj_footer.endRefreshingWithNoMoreData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {[weak self] in
                if let weakSelf = self,
                    let mj_footer = weakSelf.mj_footer {
                    mj_footer.resetNoMoreData()
                    if let completion = completion {
                        completion()
                    }
                }
            })
        }
        
    }
    
    func headerIsRefreshing() -> Bool {
        return mj_header?.isRefreshing ?? false
    }
    
    func footerIsRefreshing () -> Bool{
        return mj_footer?.isRefreshing ?? false
    }
}
