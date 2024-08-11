import 'dart:io';

import 'package:flutter_auto_flip/models/counting_model.dart';

import '../http_req.dart';
import '../../constant/urls.dart';
import 'package:flutter_auto_flip/models/load_regular_model.dart';
import '../../models/req_model.dart';

class RegularService {
  // csvで雑誌情報登録
  static Future<List<LoadRegular>> getMagazineRegular() async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.getMagazineRegular,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
    );
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 返す
    return LoadRegular.resToMagazineLoadRegular(resData['srvResData']);
  }

  static Future<List<Counting>> countingRegular(File file) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.countingRegular,
      reqType: 'MULTIPART',
      headers: {'Content-Type': 'multipart/form-data'},
      files: [file]
    );
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 返す
    return Counting.resToCounting(resData['srvResData']);
  }
}
