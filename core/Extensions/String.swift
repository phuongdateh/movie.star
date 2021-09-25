//
//  String.swift
//  core
//
//  Created by Doan Duy Phuong on 25/09/2021.
//

import Foundation

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
