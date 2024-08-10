import 'package:flutter/material.dart';
import 'dart:io';
import '../http_req.dart';

import '../../constant/urls.dart';
import '../../models/magazine_model.dart';
import '../../models/req_model.dart';

class MagazineService {
  // csvで雑誌情報登録
  static Future<void> registerForCSVMagazines(List<File> files) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.registerforCSVMagazine,
      reqType: 'MULTIPART',
      headers: {'Content-Type': 'multipart/form-data'},
      files: files,
    );
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {}
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(resData.toString());
    // 返す
  }

  // 雑誌情報取得
  static Future<List<Magazine>> getMagazines() async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.getMagazines,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
    );
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {}
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(resData.toString());
    // 返す
    return Magazine.resToMagazines(resData["srvResData"]);
  }

  // 雑誌コードで検索
  static Future<Magazine?> searchMagazineCode(String magazineCode) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.getMagazineByCode,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
      parData: magazineCode,
    );
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {}
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(resData.toString());
    // 返す
    return Magazine.resToMagazine(resData["srvResData"]);
  }

  // 雑誌名で検索
  static Future<List<Magazine>> searchMagazineName(String magazineName) async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.getMagazineByName,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
      parData: magazineName,
    );
    // リクエストメソッドにオブジェクトを投げる
    Map resData = await HttpReq.httpReq(reqData);
    // 宿題のデータがあれば
    try {
      if (resData["srvResData"] == null) {}
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(resData.toString());
    // 返す
    return Magazine.resToMagazines(resData["srvResData"]);
  }
}
