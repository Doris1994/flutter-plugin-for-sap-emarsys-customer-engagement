package com.emarsys.emarsys_sdk.mapper

import com.emarsys.predict.api.model.Product

class ProductsMapper {
    fun map(products: List<Product>): List<Map<String, Any>> {
        return products.map { element ->
            val resultMap = mutableMapOf<String, Any>(
                "productId" to element.productId,
                "linkUrl" to element.linkUrl
            )
            resultMap["available"] =  element.available ?: false
            resultMap.toMap()
        }
    }
}