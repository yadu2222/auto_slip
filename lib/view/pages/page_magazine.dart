import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/controller/magazine_controller.dart';
import 'package:flutter_auto_flip/models/magazine_model.dart';
import 'package:flutter_auto_flip/view/components/organisms/magazine_list.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
// model
import '../../models/load_regular_model.dart';
// view
import '../components/templates/basic_template.dart';
import '../components/molecles/edit_bar.dart' as regular_list;
import '../components/organisms/regular_list.dart';
// constant
import '../../constant/sample_data.dart';

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

    Future<void> serchMagazineName() async {
      // TODO：検索処理
      magazineReq.searchMagazineNameHandler(_magazineNameController.text).then((value) {
        magazines.value = value;
      });
    }

    // 一覧取得
    Future<void> getMagazine() async {
      await magazineReq.getMagazineHandler().then((value) {
        magazines.value = value;
      });
    }

    Future<void> serchMagazineCode() async {
      if (_magazineController.text == "") {
        await getMagazine();
        return;
      }
      magazineReq.searchMagazineCodeHandler(_magazineController.text).then((value) {
        magazines.value = value;
      });
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
            context.go('/home/add');
          },
          icon: const Icon(Icons.add, size: 30),
        ),
        child: Column(children: [
          // 検索バー
          // 雑誌コード
          regular_list.EditBarView(
            icon: Icons.local_offer,
            hintText: magazineCodeSearch,
            controller: _magazineController,
            search: serchMagazineCode,
            inputType: TextInputType.number,
            inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
          ),
          // 雑誌名
          regular_list.EditBarView(
            icon: Icons.import_contacts,
            hintText: magazineNameSearch,
            controller: _magazineNameController,
            search: serchMagazineName,
          ),
          // searchType.value == 0 ? Expanded(child: RegularList(regularList: regularList.value)) : Expanded(child: MagazineRegularList(regularList: regularList.value))
          MagazineList(
            magazines: magazines.value,
            onRefresh: getMagazine,
          )
        ]));
  }
}
