//
//  Created by Doris on 2021. 08. 24..
//

import EmarsysSDK

class RelateProductsCommand: EmarsysCommandProtocol {
    var mapper: ProductsMapper
    
    init(mapper: ProductsMapper) {
        self.mapper = mapper
    }
    
    func execute(arguments: [String : Any]?, resultCallback: @escaping ResultCallback) {
        let itemId = arguments?["itemId"] as? String
        let limit: NSNumber? = arguments?["limit"] as? NSNumber
        let logic = EMSLogic.related(itemId: itemId ?? "")
        Emarsys.predict.recommendProducts(logic: logic,filters:[],
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
