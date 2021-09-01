//
//  CartProductsCommand.swift
//  emarsys_sdk
//
//  Created by Doris on 2021/9/1.
//

import EmarsysSDK

class CartProductsCommand: EmarsysCommandProtocol {
    var mapper: ProductsMapper
    
    init(mapper: ProductsMapper) {
        self.mapper = mapper
    }
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        let items: Array<Dictionary<String, Any>>? = arguments?["items"] as? Array<Dictionary<String, Any>>
        let limit: NSNumber? = arguments?["limit"] as? NSNumber
        var cartItems: Array<EMSCartItem> = [];
        if items != nil {
            cartItems = items!.map({ element in
                EMSCartItem(itemId: element["id"] as? String, price: element["id"] as! Double, quantity: element["id"] as! Double)
            })
        }
        let logic = EMSLogic.cart(cartItems: cartItems)
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

