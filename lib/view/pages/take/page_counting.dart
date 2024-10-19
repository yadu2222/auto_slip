import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_auto_flip/apis/controller/customer_controller.dart';
import 'package:flutter_auto_flip/constant/messages.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/view/components/molecles/count_icons.dart';
import 'package:flutter_auto_flip/view/components/molecles/dialog.dart';
import 'package:flutter_auto_flip/view/components/organisms/add_regular_dialog.dart';
import 'package:flutter_auto_flip/view/components/organisms/counting_list.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_auto_flip/apis/controller/regular_controller.dart';
// view
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:flutter_auto_flip/view/components/organisms/main_menu.dart';
import 'package:file_picker/file_picker.dart'; // アプリがファイルを読み取るためのライブラリ

import 'dart:io';

class PageCounting extends HookWidget {
  PageCounting({super.key});

  // 新規登録
  final TextEditingController newStoreNameController = TextEditingController(); // 新しい店舗名
  final TextEditingController newCountController = TextEditingController(); // 新しい店舗名

  @override
  Widget build(BuildContext context) {
    final RegularReq regularReq = RegularReq(context: context);
    final CustomerReq customerReq = CustomerReq(context: context);
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

    // 押した雑誌から定期の登録を行う
    void onTapCounting(Counting counting) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return HookBuilder(
            builder: (BuildContext context) {
              final customers = useState<List<Customer>>([]);
              final selectCustomer = useState<Customer?>(null);

              // 定期先検索処理
              Future<void> searchStoreName(String name) async {
                final result = await customerReq.searchCustomerNameHandler(name);
                customers.value = result;
              }

              void close() {
                // 初期化しダイアログをとじる
                newCountController.clear();
                newStoreNameController.clear();
                customers.value = [];
                Navigator.of(context).pop();
              }

              // 顧客を選択
              void choise(Customer customer) {
                selectCustomer.value = customer;
                customers.value = [];

                newStoreNameController.text = customer.customerName;
              }

              // 登録処理
              void register() {
                // 顧客を選択していなければ弾く
                if (selectCustomer.value == null) {
                  DialogUtil.show(message: '顧客を選択してください', context: context);
                  return;
                }
                // 冊数の未入力を弾く
                if (newCountController.text == "") {
                  DialogUtil.show(message: '冊数が未入力です', context: context);
                  return;
                }
                // 登録処理
                regularReq.registerRegularHandler(counting.magazine.magazineCode, selectCustomer.value!.customerUUID, newCountController.text).then((value) {
                  // 登録できたよダイアログを出してあげる
                  DialogUtil.show(message: Messages.registerSuccess, context: context);
                });

                close();
              }

              return AddRegularDialog(
                magazine: counting.magazine,
                close: close,
                newStoreNameController: newStoreNameController,
                newCountController: newCountController,
                onChanged: searchStoreName,
                customers: customers.value,
                choise: choise,
                register: register,
              );
            },
          );
        },
      );
    }

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
              countList.value.isEmpty ? const SizedBox.shrink() : CountingList(loadData: countList.value, onTapCutomer: onTapCutomer, onTapCounting: onTapCounting, isCustomer: isCustomer.value),
              countList.value.isEmpty ? const SizedBox.shrink() : BasicButton(width: 300, text: '納品書をつくりますか？', isColor: true, onPressed: () {
                context.go('/delivery');
              }),
            ],
          ),
        )
      ]),
    )));
  }
}
