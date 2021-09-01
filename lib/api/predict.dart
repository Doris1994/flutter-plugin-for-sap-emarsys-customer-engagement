
import 'package:emarsys_sdk/mappers/products_mapper.dart';
import 'package:emarsys_sdk/model/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Predict {
  final MethodChannel _channel;
  final ProductsMapper _mapper;

  Predict(this._channel, this._mapper);

  Future<List<String>> recommendationLogicRelated(String itemId,
      {int limit = 12}) async {
    var messages = await _channel.invokeMethod(
        'predict.recommendationLogicRelated',
        {"itemId": itemId, 'limit': limit});
    debugPrint(
        '------------------------$messages--------------------------------');
    //List? result = jsonDecode(messages);
    if (messages == null) {
      return [];
    }
    return _mapper.map(messages);
  }

  Future<List<String>> recommendationLogicCart(List<CartItem> parameters,
      {int limit = 12}) async {
    var messages = await _channel.invokeMethod(
        'predict.recommendationLogicCart',
        {"items": parameters.map((e) => e.toMap()).toList(), 'limit': limit});
    debugPrint(
        '------------------------$messages--------------------------------');
    if (messages == null) {
      return [];
    }
    return _mapper.map(messages);
  }

  Future<List<String>> recommendationLogicHome({int limit = 12}) async {
    var messages = await _channel
        .invokeMethod('predict.recommendationLogicHome', {'limit': limit});
    debugPrint(
        '------------------------$messages--------------------------------');
    if (messages == null) {
      return [];
    }
    return _mapper.map(messages);
  }

  Future<List<String>> recommendationLogicPersonal({int limit = 12}) async {
    var messages = await _channel
        .invokeMethod('predict.recommendationLogicPersonal', {'limit': limit});
    debugPrint(
        '------------------------$messages--------------------------------');
    if (messages == null) {
      return [];
    }
    return _mapper.map(messages);
  }
}
