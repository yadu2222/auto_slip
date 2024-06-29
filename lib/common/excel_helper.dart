import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';


class ExcelHandler {
  Future<void> writeExcel(String fileName, List<List<dynamic>> data) async {
    // Excelファイルインスタンスの作成
    var excel = Excel.createExcel();
    // シートのインスタンス作成
    var sheet = excel['Sheet1'];

    // データをシートに追加
    for (var row in data) {
      sheet.appendRow(row);
    }

    // ディレクトリの取得
    var directory = await getApplicationDocumentsDirectory();
    // ファイルのパスを取得
    var filePath = '${directory.path}/$fileName';

    // エンコード
    var encodedExcel = excel.encode();
    // エンコードが成功しているかファイルに書き込む前に確認
    if (encodedExcel != null) {
      // ファイルを生成し、ディレクトリ構造が存在することを確認
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(encodedExcel);
    }
  }

  // Excelファイルの読み込み
  Future<List<List<dynamic>>> readExcel(String fileName) async {
    // ディレクトリの取得 パスの生成
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';

    // ファイルの読み込み
    var file = await File(filePath).readAsBytes();
    // ファイルのデコード
    var excel = Excel.decodeBytes(file);
    // シートの取得
    var sheet = excel['Sheet1'];
    // シートのデータをリストに格納
    List<List<dynamic>> excelData = [];
    for (var table in sheet.rows) {
      excelData.add(table);
    }
    // データを返す
    return excelData;
  }

  Future<String> readCsvFile(String filePath, Encoding encoding) async {
    File file = File(filePath);

    try {
      // 指定の文字コードでファイルを読み込む
      String contents = await file.readAsString(encoding: encoding);
      return contents;
    } catch (e) {
      print('Error reading CSV file: $e');
      return '';
    }
  }

  // サーバーに処理を移行
  // Future<void> insertCsvDataToDatabase(String csvData) async {
  //   List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvData);

  //   for (List<dynamic> row in rowsAsListOfValues) {
  //     // SQLiteデータベースにデータを挿入
  //     await DatabaseHelper.insert('your_table', {
  //       'magazine_code': row[0].toString(),
  //       'magazine_num': int.parse(row[1].toString()),
  //       'month': row[2].toString(),
  //       'magazine_name': row[3].toString(),
  //       'num': row[4].toString(),
  //       'magazine_price': row[5].toString(),
  //       // 他の列も追加
  //     });
  //   }
  // }

  // データの読み込み
  // static void excel(String path, int type) async {
  //   // ファイルオブジェクトを作成
  //   final File file = new File(path);
  //   // 読み込み
  //   Stream input = file.openRead();

  //   int constant = 0;
  //   switch (type) {
  //     case 0:
  //       // 店舗情報
  //       constant = 6;
  //       break;
  //     case 1:
  //       // 雑誌情報
  //       constant = 2;
  //       break;
  //     case 2:
  //       // 定期情報
  //       constant = 3;
  //   }

  //   // 文字コードの変換
  //   final contents = await input.transform(const Utf8Decoder(allowMalformed: true)).transform(const LineSplitter()).join();

  //   final rows = contents.split(',');
  //   print(rows);

  //   int count = 0;
  //   List dataList = []; // countの個数ずつ一つのリストにまとめる
  //   List data = []; // 各雑誌の情報を格納するリスト
  //   for (String? row in rows) {
  //     if (row == "") {
  //       row = null;
  //     }
  //     data.add(row);
  //     print(count++);
  //     if (count % constant == 0) {
  //       dataList.add(data);
  //       data = [];
  //     }
  //   }
  //   print(dataList);
  //   String tableName = "";

  //   for (int i = 0; i < dataList.length; i++) {
  //     List loadData = dataList[i];
  //     Map<String, dynamic> row = {};

  //     // TODO:すっきりさせたいねという話
  //     switch (type) {
  //       case 0:
  //         tableName = "stores";
  //         row = {"store_id": loadData[0], "store_name": loadData[1], "regular_type": loadData[2], "address": loadData[3], "tell_type": loadData[4], "note": loadData[5]};
  //         break;
  //       case 1:
  //         tableName = "magazines";
  //         row = {"magazine_code": loadData[0].toString(), "magazine_name": loadData[1]};
  //         break;
  //       case 2:
  //         tableName = "regulars";
  //         row = {"store_id": loadData[0], "magazine_code": loadData[1].toString(), "quantity": loadData[2]};
  //     }

  //     await DatabaseHelper.insert(tableName, row);
  //     print("データを追加しました");
  //   }

  //   List result = await DatabaseHelper.queryAllRows(tableName);
  //   print(result);
  // }
}
