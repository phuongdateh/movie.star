//
//  Observable+Ext.swift
//  core
//
//  Created by phuong.doan on 7/5/21.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where Element == Bool {
    /// Boolean not operator
    public func not() -> Observable<Bool> {
        return self.map(!)
    }
    
}

extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}

public extension Observable {
    func subscribe(onNext: ((Observable.Element) -> Swift.Void)?) -> Disposable {
        return subscribe(onNext: onNext, onError: nil, onCompleted: nil, onDisposed: nil)
    }
}

extension Driver {
    func _do(onNext: ((Element) -> Swift.Void)?) -> RxCocoa.SharedSequence<Self.SharingStrategy, Self.Element> {
        return self.do(onNext: onNext, afterNext: nil, onCompleted: nil, afterCompleted: nil, onSubscribe: nil, onSubscribed: nil, onDispose: nil)
    }
}

extension ObservableType {
    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
