import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/service/delivery_service.dart';
import 'package:flutter_auto_flip/models/delivery_model.dart';


class DeliveryReq {
  final BuildContext context;
  DeliveryReq({required this.context});

  // csvで数取り
  Future<List<Delivery>> getDeliveryHandler(File file) async {
    try {
      List<Delivery> result = await DeliveryService.getDelivery(file); // 取得処理を待つ
      return result;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return [];
    }
  }
}
