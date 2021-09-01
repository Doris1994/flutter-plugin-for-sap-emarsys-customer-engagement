//
//  ProductsMapper.swift
//  emarsys_sdk
//
//  Created by Doris on 2021/9/1.
//

import Foundation
import EmarsysSDK

class ProductsMapper: Mappable {
    
    typealias Input = [EMSProduct]
    typealias Output = [[String: Any]]?
    
    func map(_ input: [EMSProduct]) -> [[String : Any]]? {
        let productDicts: [[String: Any]]? = input.map { element in
            var productDict = [String: Any]()
            productDict["productId"] = element.productId
            productDict["linkUrl"] = element.linkUrl.absoluteString
            productDict["available"] = element.available
            return productDict
        }
        return productDicts
    }
    
}
