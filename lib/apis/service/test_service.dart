import 'dart:io';

import '../http_req.dart';

import '../../constant/urls.dart';
import '../../models/req_model.dart';

class TestService {


  // 接続確認
  static Future<void> connectTest() async {
    // リクエストを生成
    final reqData = Request(
      url: Urls.test,
      reqType: 'GET',
      headers: {'Content-Type': 'application/json'},
    );
    final resData = await HttpReq.httpReq(reqData);
    print(resData['srvResMsg'].toString());
  }

    // csvmagazine
  static Future<void> csvCustomer(File file) async {
    // リクエストを生成
    final reqData = Request(url: Urls.csvCustomer, reqType: 'MULTIPART', headers: {'Content-Type': 'multipart/form-data'}, files: [file]);
    // リクエストメソッドにオブジェクトを投げる
   await HttpReq.httpReq(reqData);
   
  }

  static Future<void> csvMagazine(File file) async{
    final reqData = Request(url: Urls.csvMagazine, reqType: 'MULTIPART', headers: {'Content-Type': 'multipart/form-data'}, files: [file]);
    // リクエストメソッドにオブジェクトを投げる
   HttpReq.httpReq(reqData);
  }

  static Future<void> csvRegular(File file) async{
    final reqData = Request(url: Urls.csvRegular, reqType: 'MULTIPART', headers: {'Content-Type': 'multipart/form-data'}, files: [file]);
    // リクエストメソッドにオブジェクトを投げる
   HttpReq.httpReq(reqData);
  }

}
