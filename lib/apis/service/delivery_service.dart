import 'dart:io';


import '../http_req.dart';
import '../../constant/urls.dart';
import 'package:flutter_auto_flip/models/delivery_model.dart';
import '../../models/req_model.dart';

class DeliveryService {
  // csvで数取り
  static Future<List<Delivery>> getDelivery(File file) async {
    // リクエストを生成
    final reqData = Request(url: Urls.getDelivery, reqType: 'MULTIPART', headers: {'Content-Type': 'multipart/form-data'}, files: [file]);
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 返す
    return Delivery.resToDelivery(resData['srvResData']);
  }

  
}
