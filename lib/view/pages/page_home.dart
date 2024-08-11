import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_auto_flip/apis/controller/regular_controller.dart';
// view
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:flutter_auto_flip/view/components/organisms/main_menu.dart';
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ

import 'dart:io';

class PageHome extends HookWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    final RegularReq regularReq = RegularReq(context: context);

    Future<File?> loadFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        return File(result.files.single.path!);
      } else {
        return null;
      }
    }

    // TODO:バリデーション
    // csvのみ受付？
    Future<void> counting() async {
      // ファイルを読み込み
      File? file = await loadFile();
      if (file == null) {
        // TODO: ファイルが選択されなかった場合の処理
        return;
      }
      regularReq.getRegularHandler(file);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('数をとろう'),
        ),
        body: Center(
          child: Row(children: [
            const MainMenu(),
            Expanded(
                child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Text('NOCS >> 雑誌新刊送品一覧 >> 送品＆案内一覧 >> CS外商用ダウンロード'),
                BasicButton(
                  width: 400,
                  text: 'ダウンロードしたファイルを選択してね',
                  isColor: false,
                  onPressed: counting,
                )
              ],
            )),
          ]),
        ));
  }
}
