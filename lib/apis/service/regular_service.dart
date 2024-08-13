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

  // csvで数取り
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

  // 顧客名で定期情報を取得
  static Future<List<LoadRegular>> getMagazineRegularByCustomerName(String customerName) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.getMagazineRegularByCustomerName,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
      parData: customerName,
    );
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 返す
    return LoadRegular.resToCustomerLoadRegular(resData['srvResData']);
  }

  // 雑誌名で定期情報を取得
  static Future<List<LoadRegular>> getMagazineRegularByMagazineName(String magazineName) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.getRegularByMagazineName,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
      parData: magazineName,
    );
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 返す
    return LoadRegular.resToMagazineLoadRegular(resData['srvResData']);
  }

  // 雑誌コードで定期情報を取得
  static Future<List<LoadRegular>> getMagazineRegularByMagazineCode(String magazineCode) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.getRegularByMagazineCode,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
      parData: magazineCode,
    );
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 返す
    return LoadRegular.resToMagazineLoadRegular(resData['srvResData']);
  }
}
