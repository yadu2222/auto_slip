import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../molecles/add_magazine_button.dart';

// view
import '../template/basic_template.dart';
import '../molecles/regular_form.dart';
import '../molecles/dialog.dart';
import '../organisms/add_regular_list.dart';
import '../atoms/basic_button.dart';
// constant
import '../../constant/messages.dart';
import '../../models/magazine_model.dart';

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
    // 追加する雑誌リスト
    // final magazineList = useState<List<Magazine>>([]);
    final magazineList = useState<List<Magazine>>([]);

    // コントローラのクリア処理
    void controllerClear() {
      magazineController.clear();
      magezineCodeController.clear();
      quantityController.clear();
    }

    // 配列追加処理
    void addMagazine() {
      // 空出ないことを確認
      if (magazineController.text != "" && magezineCodeController.text != "" && quantityController.text != "") {
        // 入力していた情報をリストに追加
        Magazine addMag = Magazine(magazineCode: magezineCodeController.text, magazineName: magazineController.text, quantity: quantityController.text);
        magazineList.value = List.from(magazineList.value)..add(addMag);
        controllerClear();
      }
    }

    // 配列削除処理
    void removeMagazine(int index) {
      magazineList.value = List.from(magazineList.value)..removeAt(index); // 削除
    }

    // 定期情報追加処理
    void addRegular() async {
      // 条件確認
      bool isStore = storeController.text != "";
      bool isMagazine = magazineList.value.isNotEmpty;
      String errorText = isStore && isMagazine
          ? ""
          : isStore
              ? Messages.inputNumRegularMagazineError
              : isMagazine
                  ? Messages.inputStoreNameError
                  : Messages.inputNumRegularMagazineAndStoreNameError;
      // どちらも空じゃなければ
      if (isStore && isMagazine) {
        // TODO:定期追加処理
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
          ),
          // 追加ボタン
          AddMagazineButton(add: addMagazine),
          // 入力した定期の表示
          Expanded(
              child: AddRegularList(
            magazineList: magazineList.value,
            remove: removeMagazine,
            // remove: addRegular,
          )),
          // 確定ボタン
          BasicButton(text: "確定", isColor: false, onPressed: addRegular)
        ]));
  }
}
