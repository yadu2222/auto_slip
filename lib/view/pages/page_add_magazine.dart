import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/controller/magazine_controller.dart';
import 'package:flutter_auto_flip/models/magazine_model.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auto_flip/view/components/molecles/dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// view
import '../components/templates/basic_template.dart';
import '../components/molecles/edit_bar.dart' as edit;

// 新しい顧客を追加するページ
class PageAddMagazine extends HookWidget {
  PageAddMagazine({super.key});

  // コントローラー
  final _magazineController = TextEditingController();
  final _magazineNameController = TextEditingController();

  // どちらで検索しているかを判別する変数

  final String title = '雑誌登録';
  final String magazineCodeSearch = '雑誌コード';
  final String magazineNameSearch = '雑誌名';

  @override
  Widget build(BuildContext context) {
    MagazineReq magazineReq = MagazineReq(context: context);
    void register() {
      if (_magazineController.text == '' || _magazineNameController.text == '') {
        DialogUtil.show(title: 'エラー', message: '雑誌コードと雑誌名は必須です', context: context);
      }else{

        Magazine magazine = Magazine(
          magazineCode: _magazineController.text,
          magazineName: _magazineNameController.text,
        );
        // 登録処理
        magazineReq.registerMagazineHandler(magazine).then((value) {
          DialogUtil.show(title: '登録完了', message: '雑誌を登録しました', context: context);
          _magazineController.clear();
          _magazineNameController.clear();
         
        });
      }

    }

    return BasicTemplate(title: title, children: [
      // 検索バー
      // 雑誌コード
      edit.EditBarView(
        icon: Icons.local_offer,
        hintText: magazineCodeSearch,
        controller: _magazineController,
        inputType: TextInputType.number,
        inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
      ),

      // 雑誌名
      edit.EditBarView(
        icon: Icons.import_contacts,
        hintText: magazineNameSearch,
        controller: _magazineNameController,
      ),

      const SizedBox(height: 30),

      BasicButton(
        text: '登録',
        isColor: true,
        onPressed: register,
      )
    ]);
  }
}
