import 'package:flutter/material.dart';

import 'dart:io'; // ファイル入出力用ライブラリ
import 'dart:convert';
import 'database_helper.dart';

class RegulerManager {
  // 店舗追加
  static Future<int> _addStore(String storeName) async {
    // 店舗データ追加

    // List storeDataCheck = await DatabaseHelper.queryBuilder("stores", ["store_name = ?"], [storeName], "store_id");

    // if (storeDataCheck.isEmpty) {
    //   // TODO:ここも重複で弾く処理をいれるべきでは？
    //   DatabaseHelper.insert("stores", {"store_name": storeName});
    // }

    // 追加した店舗のIDを取得
    // List storeId = await DatabaseHelper.queryBuilder("stores", ["store_name = ?"], [storeName], "store_id");
    // return storeId[0]["store_id"];
    return 0;
  }

  // 雑誌追加
  static Future<void> _addMagazine(List addMagazines) async {
    // // 雑誌データ追加
    // // 重複は無視したい
    // for (var magazine in addMagazines) {
    //   // 追加用のデータを作成
    //   Map<String, dynamic> addMagazineData = {"magazine_code": magazine["magazineCode"], "magazine_name": magazine["magazineName"]};
    //   // 重複確認のために検索
    //   List magazineData = await DatabaseHelper.queryBuilder("magazines", ["magazine_code = ?"], [magazine["magazinCode"]], "magazine_code");
    //   // 重複データがない場合のみ追加
    //   if (magazineData.isEmpty) {
    //     DatabaseHelper.insert("magazines", addMagazineData);
    //     debugPrint("雑誌データ追加");
    //   } else {
    //     DatabaseHelper.update("magazines", "magazine_code", addMagazineData, magazine["magazineCode"]);
    //     debugPrint("重複データがあるため更新に切り替え");
    //   }
    // }
  }

  // 店舗リストの取得
  static Future<List> getStores() async {
    // List storeList = await DatabaseHelper.queryBuilder("stores", [], [], "store_id");
    // return storeList;
    return [];
  }

  // 定期追加
  static Future<void> addRegular(String storeName, List addMagazines) async {
    // 店舗データ追加
    int storeId = await _addStore(storeName);
    // 雑誌データ追加
    await _addMagazine(addMagazines);
    // 定期データ追加
    for (var magazine in addMagazines) {
      // DatabaseHelper.insert("regulars", {"store_id": storeId, "magazine_code": magazine["magazineCode"], "quantity": magazine["quantity"]});
      debugPrint("定期データ追加");
    }
  }

  // 定期リストの検索と取得
  static Future<List> getRegularList(String? searchData, int searchType) async {
    // 0なら店舗名検索、1なら雑誌コード検索、それ以外なら全件取得
    // 入力の有無でも弾く
    // if (searchData != "") {
    //   debugPrint("検索あり");
    //   if (searchData != null) {
    //     return await DatabaseHelper.searchRegulerList(searchType, "");
    //   } else {
    //     return [];
    //   }
    // } else {
    //   debugPrint("検索なし");
    //   // 全件取得
    //   List storeList = [];
    //   switch (searchType) {
    //     case 0:
    //       storeList = await DatabaseHelper.searchRegulerList(10, "");
    //     default:
    //       storeList = await DatabaseHelper.searchRegulerList(11, "");
    //   }
    //   return storeList;
    // }

    return [];
  }

  // 定期データの取得
  // TODO:いまのところつかってないよ
  // 2023.3.16 使ってるっぽいよ、、、？
  // やっぱいらないね
  // static Future<List> getsearchData(String searchData, int searchType) async {
  //   List regularData = await DatabaseHelper.searchRegulerList(searchType, searchData);
  //   return regularData;
  // }

  // サーバーに処理を移行
  // 入荷リストのデータ取得
  // static Future<List> getImportData(String path) async {
  //   try {
  //     // ファイルオブジェクトを作成
  //     final File file = new File(path);
  //     // 読み込み
  //     Stream input = file.openRead();

  //     final contents = await input.transform(const Utf8Decoder(allowMalformed: true)).transform(const LineSplitter()).join();

  //     // 改行コードがlfであることが確認できたが、うまくとれない；；
  //     // final rows = contents.split('0A');
  //     final rows = contents.split(',');
  //     print(rows);

  //     int count = 1; // 22個でカウントして止めたい
  //     // 文字化けが一向に治らないので一旦雑誌コードのみでの運用を想定する
  //     // TODO:誌名も取得したい
  //     // 各リストの要素６個目が雑誌コード、12個目が冊数
  //     List magazinesList = []; // 22個ずつで一つのリストにまとめる
  //     List magazine = []; // 各雑誌の情報を格納するリスト
  //     for (String row in rows) {
  //       if (row == "") {
  //         row = "0";
  //       }
  //       magazine.add(row);
  //       print(count++);
  //       if (count % 23 == 0) {
  //         magazinesList.add(magazine);
  //         magazine = [];
  //       }
  //     }
  //     print(magazinesList);

  //     await DatabaseHelper.createImportDateTable();
  //     // 作ったdbにデータを格納していく
  //     // 0はヘッダーなので1から始める
  //     for (int i = 1; i < magazinesList.length; i++) {
  //       List importData = magazinesList[i];
  //       Map<String, dynamic> row = {
  //         'magazine_code': importData[5],
  //         'quantity_in_stock': importData[11],
  //       };
  //       await DatabaseHelper.insert("importData", row);
  //       print("データを追加しました");
  //     }

  //     List result = await DatabaseHelper.queryAllRows("importData");
  //     print(result);

  //     List result2 = await DatabaseHelper.getRegulerMagazine();
  //     print(result2);

  //     return result2;
  //   } catch (e) {
  //     print(e);

  //     return [];
  //   } finally {
  //     // 用が済んだテーブルを削除
  //     await DatabaseHelper.dropTable();
  //   }
  // }
}
