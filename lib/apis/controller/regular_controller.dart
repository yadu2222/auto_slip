import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
import 'package:flutter_auto_flip/models/load_regular_model.dart';
import 'package:go_router/go_router.dart';
import '../../../constant/messages.dart';

// view
// import '../../view/components/atoms/toast.dart';
// model

// service
import '../service/regular_service.dart';

class RegularReq {
  final BuildContext context;
  RegularReq({required this.context});

  // csvで雑誌情報登録
  Future<List<LoadRegular>> getMagazineRegularHandler() async {
    try {
      List<LoadRegular> result = await RegularService.getMagazineRegular(); // 取得処理を待つ

      return result;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return [];
    }
  }

  // csvで数取り
  Future<List<Counting>> getRegularHandler(File file) async {
    try {
      List<Counting> result = await RegularService.countingRegular(file); // 取得処理を待つ
      return result;
    } catch (error) {
      debugPrint(error.toString());
      debugPrint("しっぱい"); // 取得失敗メッセージ
      return [];
    }
  }
}
