import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/view/components/atoms/basic_button.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
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


    // 
    void register(){

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
      BasicButton(text: '登録', isColor: true,onPressed: register)
    ]);
  }
}
