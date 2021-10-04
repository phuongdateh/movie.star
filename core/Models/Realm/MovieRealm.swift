//
//  MovieRealm.swift
//  core
//
//  Created by Doan Duy Phuong on 03/10/2021.
//

import Foundation
import RealmSwift

final class MovieRealm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String?
    @objc dynamic var posterPath: String?
    @objc dynamic var backdropPath: String?
    @objc dynamic var releaseDate: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int,
                     title: String?,
                     posterPath: String?,
                     backdropPath: String?,
                     releaseDate: String?) {
        self.init()
        self.id = id
        self.title = title
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
}

extension MovieRealm {
    static func favorite(movie: Movie) {
        let realm = try! Realm()
        if let obj = realm.object(ofType: MovieRealm.self, forPrimaryKey: movie.id),
           obj.isInvalidated == false {
            realm.safeWrite {
                realm.delete(obj)
            }
        } else {
            movie.favorite()
        }
    }
    
    static func favorite(movie: MovieDetail) {
        let realm = try! Realm()
        if let obj = realm.object(ofType: MovieRealm.self, forPrimaryKey: movie.id),
           obj.isInvalidated == false {
            realm.safeWrite {
                realm.delete(obj)
            }
        } else {
            movie.favorite()
        }
    }
    
    static func currentList() -> Results<MovieRealm> {
        let realm = try! Realm()
        return realm.objects(MovieRealm.self)
    }
}

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) {
        if isInWriteTransaction == true {
            try! block()
        }
        else {
            try! write(block)
        }
    }
}
