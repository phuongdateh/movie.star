//
//  ProfileViewModel.swift
//  core
//
//  Created by phuong.doan on 8/1/21.
//

import Foundation

class ProfileViewModel: ViewModel {
    private var items: [ProfileItem] = [.myFavoriteList, .rateApp, .feedback, .about]
    
    
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return self.items.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> ProfileItem {
        return self.items[indexPath.row]
    }
}
