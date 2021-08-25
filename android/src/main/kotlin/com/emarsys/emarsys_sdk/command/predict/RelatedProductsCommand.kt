package com.emarsys.emarsys_sdk.command.predict

import com.emarsys.Emarsys
import com.emarsys.predict.api.model.RecommendationFilter
import com.emarsys.predict.api.model.RecommendationLogic
import com.emarsys.emarsys_sdk.command.EmarsysCommand
import com.emarsys.emarsys_sdk.command.ResultCallback
import com.emarsys.predict.api.model.Product
import com.emarsys.emarsys_sdk.mapper.ProductsMapper
import com.emarsys.core.api.result.*
import java.util.*
import android.util.Log;

import android.os.Handler;
import android.os.Looper;

// import org.json.JSONArray
// import org.json.JSONObject

class RelatedProductsCommand(private val productsMapper: ProductsMapper) : EmarsysCommand {
    
    val mHandler = Handler(Looper.getMainLooper())

    override fun execute(parameters: Map<String, Any?>?, resultCallback: ResultCallback) {
        val itemId = parameters?.get("itemId") as? String
        val limit = parameters?.get("limit") as? Int
        val logic = RecommendationLogic.related(itemId ?: "")
        Emarsys.predict.recommendProducts(logic,emptyList<RecommendationFilter>(),limit ?: 10){ result ->
            mHandler.post{
                if (result.errorCause != null) {
                    resultCallback.invoke(null, result.errorCause)
                } else{
                    resultCallback.invoke((productsMapper.map(result.result as List<Product>)), null)
                }
            }
            // it.result?.let { result ->
            // resultCallback.invoke((inboxResultMapper.map(result.result as InboxResult)), null)
            //     mHandler.post{
            //         val jsonArray = JSONArray()
            //         for (item in result) {
            //             var jsonObject = JSONObject()
            //             jsonObject.put("productId",item.productId)
            //             jsonObject.put("linkUrl",item.linkUrl)
            //             jsonObject.put("available",item.available)
            //             jsonArray.put(jsonObject)
            //         }
            //         val jsonResult = jsonArray.toString()
            //         Log.e("RelatedProductsCommand", "get result: ${jsonResult}")
            //         resultCallback.invoke(jsonResult, null)
            //     }
            // }
            // it.errorCause?.let { cause ->
            //     Log.e("RelatedProductsCommand", "Error happened: ${cause.message}")
            // }
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