package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.predict.api.model.RecommendationFilter
import com.emarsys.predict.api.model.RecommendationLogic
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.predict.api.model.Product
import com.emarsys.predict.api.model.PredictCartItem
import com.emarsys.emarsys_sdk.mapper.ProductsMapper
import com.emarsys.core.api.result.*
import java.util.*
import android.util.Log;

import android.os.Handler;
import android.os.Looper;

class CartProductsCommand(private val productsMapper: ProductsMapper) : EmarsysCommand {
    val mHandler = Handler(Looper.getMainLooper())

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val items = parameters?.get("items") as? List<Map<String, Any>>?
        val limit = parameters?.get("limit") as? Int
        var cartItems = emptyList<PredictCartItem>()
        if (items != null) {
            cartItems = items.map { element ->
                PredictCartItem(
                    element["id"] as String,
                    element["price"] as Double,
                    element["qty"] as Double)
            }
        }
        val logic = RecommendationLogic.cart(cartItems)

        Emarsys.predict.recommendProducts(logic,emptyList<RecommendationFilter>(),limit ?: 10){ result ->
            mHandler.post{
                if (result.errorCause != null) {
                    resultCallback.invoke(null, result.errorCause)
                } else{
                    resultCallback.invoke((productsMapper.map(result.result as List<Product>)), null)
                }
            }
        }
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false
        return true
    }

    override fun hashCode(): Int {
        return javaClass.hashCode()
    }

}