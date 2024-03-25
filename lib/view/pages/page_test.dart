import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart'; // アプリがファイルを保存可能な場所を取得するライブラリ
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ

import '../../data/excel_helper.dart';

class Test extends StatefulWidget {
  @override
  _Test createState() => _Test();
}

class _Test extends State<Test> {
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
              ExcelHandler.excel(path, type);
            } else {
              // ファイルが選択されなかった場合の処理
            }
          },
          child: Text(text),
        ),
      );
    }

    // 表示するリスト

    return Scaffold(
        appBar: AppBar(
          title: const Text('データを読み込もう'),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [loadBottun("連絡先を読み込む", 0), loadBottun("雑誌情報を読み込む", 1), loadBottun("定期情報を読み込む", 2)],
            ),
          ),
        ));
  }
}
