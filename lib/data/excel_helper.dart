import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import '../data/database_helper.dart';
import 'package:csv/csv.dart';

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

  Future<void> insertCsvDataToDatabase(String csvData) async {
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvData);

    for (List<dynamic> row in rowsAsListOfValues) {
      // SQLiteデータベースにデータを挿入
      await DatabaseHelper.insert('your_table', {
        'magazine_code': row[0].toString(),
        'magazine_num': int.parse(row[1].toString()),
        'month': row[2].toString(),
        'magazine_name': row[3].toString(),
        'num': row[4].toString(),
        'magazine_price': row[5].toString(),
        // 他の列も追加
      });
    }
  }
}
