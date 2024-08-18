

import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart'; // アプリがファイルを保存可能な場所を取得するライブラリ
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ
import 'package:flutter_auto_flip/apis/controller/test_controller.dart';
import 'package:flutter_auto_flip/view/components/templates/basic_template.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// import '../../apis/controller/test_controller.dart';
// import '../../apis/controller/magazine_controller.dart';

class Test extends StatefulWidget {
  @override
  _Test createState() => _Test();
}

class _Test extends State<Test> {
  @override
  Widget build(BuildContext context) {
    TestReq testReq = TestReq(context: context);

    Future<File?> loadFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        return File(result.files.single.path!);
      } else {
        return null;
      }
    }

    Future<void> csvRegister(int type) async {
      // ファイルを読み込み
      File? file = await loadFile();
      if (file == null) {
        // TODO: ファイルが選択されなかった場合の処理
        return;
      }
      await testReq.csvRegisterHandler(file, type);
    }

    Widget loadBottun(String text, int type) {
      return ElevatedButton(
        // 入荷データのファイル読み込み
        // 印刷までしたい
        onPressed: () async {
          await csvRegister(type);
        },

        child: Text(text),
      );
    }

    return BasicTemplate(title: 'CSVからデータを読み込もう', children: [loadBottun("連絡先を読み込む", 1), loadBottun("雑誌情報を読み込む", 2), loadBottun("定期情報を読み込む", 3)]);
  }
}
