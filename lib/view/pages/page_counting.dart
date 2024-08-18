import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
import 'package:flutter_auto_flip/view/components/molecles/count_icons.dart';
import 'package:flutter_auto_flip/view/components/organisms/counting_list.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_auto_flip/apis/controller/regular_controller.dart';
// view
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:flutter_auto_flip/view/components/organisms/main_menu.dart';
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ

import 'dart:io';

class PageCounting extends HookWidget {
  const PageCounting({super.key});

  @override
  Widget build(BuildContext context) {
    final RegularReq regularReq = RegularReq(context: context);
    final countList = useState<List<Counting>>([]);
    final isCustomer = useState<bool>(true);

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
      await regularReq.getRegularHandler(file).then((value) => countList.value = value);
    }

    void onTapCutomer(CountingCustomer customer) {}
    void onTapCounting(Counting counting) {}

    void show() {
      isCustomer.value = !isCustomer.value;
    }

    return Scaffold(
        body: Center(
            child: Container(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        const MainMenu(),
        Expanded(
          child: Column(
            children: [
              AppBar(title: const Text('数をとろう')),
              const Text('NOCS >> 雑誌新刊送品一覧 >> 送品＆案内一覧 >> 雑誌コード順に並び替え >> CS外商用ダウンロード'),
              BasicButton(
                width: 400,
                text: 'ダウンロードしたファイルを選択してね',
                isColor: false,
                onPressed: counting,
              ),
              // 数取リストの有無で表示を制御
              countList.value.isEmpty
                  ? const SizedBox.shrink()
                  : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      InkWell(
                        onTap: show,
                        child: Row(children: [
                          const Icon(Icons.expand_more),
                          Text(isCustomer.value ? '顧客情報を隠す' : '顧客情報を表示'),
                        ]),
                      ),
                      const CountIcons(), // 各アイコンの説明
                    ]),
              // 数取リストの有無で表示を制御
              countList.value.isEmpty ? const SizedBox.shrink() : CountingList(loadData: countList.value, onTapCutomer: onTapCutomer, onTapCounting: onTapCounting, isCustomer: isCustomer.value)
            ],
          ),
        )
      ]),
    )));
  }
}
