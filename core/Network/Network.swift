//
//  Network.swift
//  core
//
//  Created by phuong.doan on 7/3/21.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

class Network<T: Decodable> {
    private let endPoint: String
    private let headers: [String: String]
    private let parameters: [String: Any]
    private let scheduler: ConcurrentDispatchQueueScheduler

    init(_ endPoint: String,
         headers: [String: String],
         parameters: [String: Any]) {
        self.endPoint = endPoint
        self.headers = headers
        self.parameters = parameters
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }

    func getItems(_ path: String) -> Observable<[T]> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .data(.get,
                  absolutePath,
                  parameters: self.parameters ,
                  headers: HTTPHeaders(self.headers))
            .debug()
            .observe(on: scheduler)
            .map({ data -> [T] in
                return try JSONDecoder().decode([T].self, from: data)
            })
    }
    
    func getItem(_ path: String) -> Observable<T> {
        let absolutePath: String = "\(endPoint)/\(path)"
        return RxAlamofire
            .data(.get, absolutePath, parameters: self.parameters, headers: HTTPHeaders(self.headers))
            .debug()
            .observe(on: scheduler)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
        }
    }

    func getItem(_ path: String, itemId: String) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
            .data(.get, absolutePath)
            .debug()
            .observe(on: scheduler)
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }

    func postItem(_ path: String, parameters: [String: Any]) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .request(.post, absolutePath, parameters: parameters)
            .debug()
            .observe(on: scheduler)
            .data()
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }

    func updateItem(_ path: String, itemId: String, parameters: [String: Any]) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
            .request(.put, absolutePath, parameters: parameters)
            .debug()
            .observe(on: scheduler)
            .data()
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }

    func deleteItem(_ path: String, itemId: String) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        return RxAlamofire
            .request(.delete, absolutePath)
            .debug()
            .observe(on: scheduler)
            .data()
            .map({ data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            })
    }
}
