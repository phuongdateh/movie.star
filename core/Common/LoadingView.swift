//
//  LoadingView.swift
//  core
//
//  Created by Doan Duy Phuong on 03/10/2021.
//

import Foundation
import NVActivityIndicatorView
import SnapKit

class LoadingView: UIView {
    
    var indicatorType: NVActivityIndicatorType = .ballGridBeat
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let loadingView = NVActivityIndicatorView.init(frame: frame)
        loadingView.type = indicatorType
        loadingView.color = .lightGray
        loadingView.padding = 10
        loadingView.startAnimating()
        
        addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

typealias IndicatorType = NVActivityIndicatorType
extension NVActivityIndicatorType {
    func view(frame: CGRect, with color: UIColor = .white) -> UIView {
        switch self {
        case .ballSpinFadeLoader:
            let view = NVActivityIndicatorView(frame: frame)
            view.type = self
            view.padding = 10
            view.color = color
            view.startAnimating()
            return view
        default:
            return .init()
        }
    }
}
