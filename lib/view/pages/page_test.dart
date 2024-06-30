import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/view/parts/molecules.dart';
import 'package:path_provider/path_provider.dart'; // アプリがファイルを保存可能な場所を取得するライブラリ
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ

import '../../common/excel_helper.dart';

import '../../models/database_helper.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  @override
  _Test createState() => _Test();
}

class _Test extends State<Test> {
  Future<void> _uploadCsv(File csvFile) async {
    // CSVファイルを読み込む
    List<int> csvBytes = await csvFile.readAsBytes();

    // HTTPリクエストの設定
    Uri url = Uri.parse('http://127.0.0.1:8080/v1/csv/magazines');
    Map<String, String> headers = {
      'Content-Type': 'text/csv', // CSVファイZルの場合、Content-Type を text/csv に設定する
    };
    // CSVデータをBase64エンコードしてbodyに設定
    String body = base64.encode(csvBytes);

    // // HTTP POSTリクエストの送信
    // http.Response response = await http.post(url, headers: headers, body: body);

    try {
      http.Response response = await http.post(url, headers: headers, body: body);
      // レスポンスの処理

      if (response.statusCode == 200) {
        print("Success");
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;

    Widget loadBottun(String text, int type) {
      return Container(
        width: screenSizeWidth * 0.4,
        height: screenSizeHeight * 0.05,
        // 入荷データのファイル読み込み
        // 印刷までしたい
        child: ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              String path = result.files.single.path!;
              // ExcelHandler.excel(path, type);
              _uploadCsv(File(path));
            } else {
              // ファイルが選択されなかった場合の処理
            }
          },
          child: Text(text),
        ),
      );
    }

    // 表示するリスト

    TextEditingController controller = TextEditingController();
    List test = [];

    void function(int n) async {
      // test = await DatabaseHelper.queryBuilder("magazines", ["magazine_code = ?"], [controller.text.toString()], "magazine_code");
      setState(() {
        print(test);
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('データを読み込もう'),
        ),
        body: Center(
            child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // children: [loadBottun("連絡先を読み込む", 0), loadBottun("雑誌情報を読み込む", 1), loadBottun("定期情報を読み込む", 2), Parts.searchBar(Icons.search, '検索してみよう', controller, 0, function)]),
          ),
        )));
  }
}
