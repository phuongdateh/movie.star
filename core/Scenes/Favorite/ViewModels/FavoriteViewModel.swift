//
//  FavoriteViewModel.swift
//  core
//
//  Created by Doan Duy Phuong on 03/10/2021.
//

import Foundation
import RealmSwift

class FavoriteViewModel: ViewModel {
    var movies: Results<MovieRealm>!
    
    override init() {
        super.init()
        self.initMovies()
    }
    
    private func initMovies() {
        let realm = try! Realm()
        self.movies = realm.objects(MovieRealm.self)
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return self.movies.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> MovieRealm {
        return self.movies[indexPath.row]
    }
}
