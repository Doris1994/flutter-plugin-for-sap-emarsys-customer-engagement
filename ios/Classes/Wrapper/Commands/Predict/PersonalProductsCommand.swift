//
//  PersonalProductsCommand.swift
//  emarsys_sdk
//
//  Created by Doris on 2021/9/1.
//

import EmarsysSDK

class PersonalProductsCommand: EmarsysCommandProtocol {
    var mapper: ProductsMapper
    
    init(mapper: ProductsMapper) {
        self.mapper = mapper
    }
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        let limit: NSNumber? = arguments?["limit"] as? NSNumber
        let logic = EMSLogic.personal()
        Emarsys.predict.recommendProducts(logic: logic,
                                          filters:[],
                                          limit: limit ?? 10 as NSNumber) { products, error in
            if let products = products {
                if let productDicts = self.mapper.map(products) {
                    resultCallback(["success": productDicts])
                } else {
                    resultCallback(["success": []])
                }
            } else if let error = error {
                resultCallback(["error": error])
            }
        }
    }
}
