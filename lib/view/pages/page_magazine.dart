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
import 'package:flutter_auto_flip/view/components/organisms/magazine_list.dart';

class PageMagazine extends HookWidget {
  PageMagazine({super.key});

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

    // 一覧取得
    Future<void> getMagazine() async {
      await magazineReq.getMagazineHandler().then((value) {
        magazines.value = value;
      });
    }

    // 雑誌名検索
    Future<void> serchMagazineName() async {
      if (_magazineNameController.text == "") {
        await getMagazine();
        return;
      }
      magazineReq.searchMagazineNameHandler(_magazineNameController.text).then((value) {
        magazines.value = value;
      });
    }

    // 雑誌コード検索
    Future<void> serchMagazineCode() async {
      if (_magazineController.text == "") {
        await getMagazine();
        return;
      }
      magazineReq.searchMagazineCodeHandler(_magazineController.text).then((value) {
        magazines.value = value;
      });
    }

    void onTap(Magazine magazine) {
      // context.push('/regular', extra: {'serachWord': magazine.magazineCode});
      // ダイアログ表示
    }

    useEffect(() {
      getMagazine();
      return null;
    }, []);

    return BasicTemplate(
        title: title,
        floatingActionButton: IconButton(
          onPressed: () {
            // 追加画面に遷移
            context.go('/magazine/add');
          },
          icon: const Icon(Icons.add, size: 30),
        ),
        children: [
          // 検索バー
          // 雑誌コード
          edit.EditBarView(
            icon: Icons.local_offer,
            hintText: magazineCodeSearch,
            controller: _magazineController,
            search: serchMagazineCode,
            inputType: TextInputType.number,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
          ),
          // 雑誌名
          edit.EditBarView(
            icon: Icons.import_contacts,
            hintText: magazineNameSearch,
            controller: _magazineNameController,
            search: serchMagazineName,
          ),
          MagazineList(magazines: magazines.value, onRefresh: getMagazine, onTap: onTap)
        ]);
  }
}
