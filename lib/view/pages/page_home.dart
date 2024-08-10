import 'package:flutter/material.dart';
import 'dart:io'; // ファイル入出力用ライブラリ
import 'dart:async'; // 非同期処理用ライブラリ

import 'package:path_provider/path_provider.dart'; //アプリがファイルを保存可能な場所を取得するライブラリ

import 'package:flutter_auto_flip/view/components/organisms/main_menu.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  // 入力された内容を保持するコントローラ
  final outputController = TextEditingController();

  // 表示用の変数
  String inputText = "0回出力しました";
  int inputNum = 0;

  // 出力するを押されたときの動作
  void output(String str) async {
    setState(() {
      ++inputNum;
      inputText = '$inputNum回出力しました';
    });

    // thenの記述で非同期処理であるgetFilePath()の処理を待っている
    getFilePath().then((File file) {
      file.writeAsString(str);
    });
  }

  void loadFile() {
    setState(() {
      load().then((String value) {
        setState(() {
          inputText = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('伝票をつくろう！！！！！'),
         
        ),
        body: Center(
          child: Row(children: [
            const MainMenu(),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 300,
                    height: 100,
                    child: TextField(
                      enabled: true,
                      maxLength: 10,
                      maxLines: 1,
                      controller: outputController,
                      decoration: const InputDecoration(
                        labelText: '出力する文字を入力してください',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    output(outputController.text);
                  },
                  child: const Text("ファイルを出力する"),
                ),
                GestureDetector(
                  onTap: () {
                    loadFile();
                  },
                  child: const Text("ファイルを読み込む"),
                ),
                Text(inputText)
              ],
            ),
          ]),
        ));
  }
}

Future<File> getFilePath() async {
  final directory = await getTemporaryDirectory();
  return File('${directory.path}/data.txt');
}

// テキストファイルの読み込み
Future<String> load() async {
  final file = await getFilePath();
  return file.readAsString();
}
