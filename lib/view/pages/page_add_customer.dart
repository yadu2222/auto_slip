import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// model
import 'package:flutter_auto_flip/models/magazine_model.dart';
// api
import 'package:flutter_auto_flip/apis/controller/magazine_controller.dart';
// view
import '../components/templates/basic_template.dart';
import '../components/molecles/edit_bar.dart' as edit;

// 新しい顧客を追加するページ
class PageAddCustomer extends HookWidget {
  PageAddCustomer({super.key});

  // コントローラー
  final _magazineController = TextEditingController();
  final _magazineNameController = TextEditingController();

  // どちらで検索しているかを判別する変数

  final String title = '雑誌一覧';
  final String magazineCodeSearch = '雑誌コードで検索';
  final String magazineNameSearch = '誌名で検索';

  @override
  Widget build(BuildContext context) {
    MagazineReq magazineReq = MagazineReq(context: context);
    final magazines = useState<List<Magazine>>([]);

    return BasicTemplate(
        title: title,
        floatingActionButton: IconButton(
          onPressed: () {
            // 追加画面に遷移
            context.go('/home/add');
          },
          icon: const Icon(Icons.add, size: 30),
        ),
        children:  [
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
        ]);
  }
}
