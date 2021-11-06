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

    func convertToQueryFormat() -> String {
            let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
            let subDelimitersToEncode = "!$&'()*+,;="
            
            var allowedCharacterSet = CharacterSet.urlQueryAllowed
            allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
            
            var escaped = ""
            
            //==========================================================================================================
            //
            //  Batching is required for escaping due to an internal bug in iOS 8.1 and 8.2. Encoding more than a few
            //  hundred Chinese characters causes various malloc error crashes. To avoid this issue until iOS 8 is no
            //  longer supported, batching MUST be used for encoding. This introduces roughly a 20% overhead. For more
            //  info, please refer to:
            //
            //      - https://github.com/Alamofire/Alamofire/issues/206
            //
            //==========================================================================================================
            
            if #available(iOS 8.3, *) {
                escaped = addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? self
            } else {
                let batchSize = 50
                var index = startIndex
                
                while index != endIndex {
                    let startIndex = index
                    let endIndex = self.index(index, offsetBy: batchSize, limitedBy: self.endIndex) ?? self.endIndex
                    let range = startIndex..<endIndex
                    
                    let substring = self[range]
                    
                    escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)
                    
                    index = endIndex
                }
            }
            
            return escaped
        }
}
