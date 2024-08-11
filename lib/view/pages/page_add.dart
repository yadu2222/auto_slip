import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/controller/magazine_controller.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../components/molecles/add_magazine_button.dart';

// view
import '../components/templates/basic_template.dart';
import '../components/molecles/regular_form.dart';
import '../components/molecles/dialog.dart';
import '../components/organisms/add_regular_list.dart';
import '../components/atoms/basic_button.dart';
// constant
import '../../constant/messages.dart';
import '../../models/regular_model.dart';
import '../../models/magazine_model.dart';
import '../../models/customer_model.dart';

// TODO: 定期追加ページ
class PageAdd extends HookWidget {
  PageAdd({super.key});

  final String title = '定期追加';

  // 入力された内容を保持するコントローラ
  final TextEditingController storeController = TextEditingController();
  final TextEditingController magazineController = TextEditingController();
  final TextEditingController magezineCodeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MagazineReq magazineReq = MagazineReq(context: context);

    // 定期先の検索結果と選択された定期先
    final customers = useState<List<Customer>>([]);
    final customer = useState<Customer?>(null);
    // 検索結果と選択された雑誌
    final magazines = useState<List<Magazine>>([]);
    final magazine = useState<Magazine?>(null);
    // 追加中の雑誌リスト
    final registerList = useState<List<CountingRegular>>([]);
    final newMagazine = useState<bool>(false);

    // newMagazineの変更
    void changeNewMagazine() {
      newMagazine.value = !newMagazine.value;
    }

    // コントローラのクリア処理
    void controllerClear() {
      magazineController.clear();
      magezineCodeController.clear();
      quantityController.clear();
    }

    // 配列追加処理
    void addMagazine() {
      // 空でないことを確認
      if (magazineController.text != "" && magezineCodeController.text != "" && quantityController.text != "") {
        // 入力していた情報をリストに追加
        // Magazine addMagazine = Magazine(magazineCode: magezineCodeController.text, magazineName: magazineController.text);

        Regular addRegular = Regular(quantity: int.parse(quantityController.text));
        registerList.value = [...registerList.value, (CountingRegular(regular: addRegular, magazine: Magazine(magazineName: magazineController.text, magazineCode: magezineCodeController.text)))];
        controllerClear();
      } else {
        DialogUtil.show(
          title: "エラー",
          message: Messages.inputError,
          context: context,
        );
      }
    }

    // 配列削除処理
    void removeMagazine(int index) {
      registerList.value = List.from(registerList.value)..removeAt(index); // 削除
    }

    // 雑誌コード検索処理
    // onchangeに反応して検索処理を行う
    Future<void> searchMagazineCode(String code) async {
      await magazineReq.searchMagazineCodeHandler(code).then((value) {
        magazines.value = value;
      });
    }

    // 雑誌名検索処理
    // onchangeに反応して検索処理を行う
    Future<void> searchMagazineName(String name) async {
      await magazineReq.searchMagazineNameHandler(name).then((value) {
        magazines.value = value;
      });
    }

    // 選択処理
    void selectMagazine(Magazine selectMagazine) {
      magazine.value = selectMagazine;
      magazineController.text = selectMagazine.magazineName;
      magezineCodeController.text = selectMagazine.magazineCode;
      magazines.value = [];
    }

    // 定期情報追加処理
    void addRegular() async {
      // 条件確認
      bool isStore = storeController.text != "";
      bool isMagazine = registerList.value.isNotEmpty;
      String errorText = isStore && isMagazine
          ? ""
          : isStore
              ? Messages.inputNumRegularMagazineError
              : isMagazine
                  ? Messages.inputStoreNameError
                  : Messages.inputNumRegularMagazineAndStoreNameError;
      // どちらも空じゃなければ
      if (isStore && isMagazine) {
        // TODO:api定期追加処理
        debugPrint("追加処理");
        // 完了ダイアログ
        DialogUtil.show(
          message: Messages.registerSuccess,
          context: context,
        );
      } else {
        DialogUtil.show(context: context, title: Messages.errorTitle, message: errorText);
      }
    }

    return BasicTemplate(
        title: title,
        child: Column(children: [
          // 定期情報の入力
          RegularForm(
            storeController: storeController,
            magazineNameController: magazineController,
            magezineCodeController: magezineCodeController,
            quantityController: quantityController,
            newMagazine: newMagazine.value,
            customerData: customers.value,
            magazineData: magazines.value,
            serachMagazineCode: searchMagazineCode,
            changeNewMagazine: changeNewMagazine,
            selectMagazine: selectMagazine,
            serachMagazineName: searchMagazineName,
          ),
          const SizedBox(height: 10),
          // 追加ボタン
          AddMagazineButton(add: addMagazine),
          // 入力した定期の表示
          registerList.value.isEmpty
              ? const SizedBox.shrink()
              : AddRegularList(
                  regularList: registerList.value,
                  remove: removeMagazine,
                  // remove: addRegular,
                ),
          // 確定ボタン
          registerList.value.isEmpty ? const SizedBox.shrink() : BasicButton(text: "確定", isColor: false, onPressed: addRegular)
        ]));
  }
}
