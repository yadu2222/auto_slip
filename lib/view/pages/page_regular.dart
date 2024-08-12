import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_auto_flip/view/components/molecles/count_icons.dart';
import 'package:flutter_auto_flip/view/components/templates/basic_template.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../components/molecles/edit_bar.dart' as edit;
import 'package:flutter_auto_flip/apis/controller/regular_controller.dart';
// mode;
import '../../models/load_regular_model.dart';
import '../components/organisms/regular_list.dart';

class PageRegularMagazine extends HookWidget {
  final String serachWord;

  final TextEditingController userNameController; // 編集者の名前
  final TextEditingController storeNameController; // 店舗名
  final TextEditingController magazineCodeController; // 雑誌コード

  PageRegularMagazine({super.key, required this.serachWord})
      : userNameController = TextEditingController(),
        storeNameController = TextEditingController(),
        magazineCodeController = TextEditingController() {
    // 初期化処理

    magazineCodeController.text = serachWord;
  }

  @override
  Widget build(BuildContext context) {
    // //画面サイズ
    // var screenSizeWidth = MediaQuery.of(context).size.width;
    // var screenSizeHeight = MediaQuery.of(context).size.height;
    RegularReq regularReq = RegularReq(context: context);
    final regularList = useState<List<LoadRegular>>([]);
    final magazineList = useState<Widget>(const Text("からっぽです"));

    Future<void> getRegular() async {
      await regularReq.getMagazineRegularHandler().then((value) {
        regularList.value = value;
      });
    }

    useEffect(() {
      getRegular();
      return null;
    }, []);

    // regularListが更新されたときにmagazineListを更新
    useEffect(() {
      magazineList.value = RegularList(
        regularList: regularList.value,
        onTap: (customer) => print(customer),
      );
      return null;
    }, [regularList.value]);

    return BasicTemplate(
      title: '定期',
      floatingActionButton: IconButton(
        onPressed: () {
          // 追加画面に遷移
          context.go('/regular/add');
        },
        icon: const Icon(Icons.add, size: 30),
      ),
      children: [
        const SizedBox(height: 30),
        // edit.EditBarView(
        //   // 名前の入力
        //   controller: userNameController,
        //   hintText: 'あなたの名前はなんですか',
        //   icon: Icons.edit,
        // ),
        edit.EditBarView(
          icon: Icons.local_offer,
          hintText: '雑誌コード',
          controller: magazineCodeController,
          search: () {},
          inputType: TextInputType.number,
          inputFormatter: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(5)],
        ),
        edit.EditBarView(
          icon: Icons.import_contacts,
          hintText: '雑誌名',
          controller: magazineCodeController,
          search: () {},
        ),
        edit.EditBarView(
          icon: Icons.person,
          hintText: '顧客名',
          controller: magazineCodeController,
          search: () {},
        ),
        const CountIcons(),
        const SizedBox(height: 10),
        magazineList.value,
      ],
    );
  }
}
