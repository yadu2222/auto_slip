import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/apis/controller/regular_controller.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../components/templates/tab_template.dart';
import '../components/templates/tab_child_template.dart';
import '../components/organisms/regular_list.dart';

// mode;
import '../../models/load_regular_model.dart';
// sample
// import '../../constant/sample_data.dart';

class PageEdit extends HookWidget {
  final int startIndex;
  final String serachWord;

  final TextEditingController userNameController; // 編集者の名前
  final TextEditingController storeNameController; // 店舗名
  final TextEditingController magazineCodeController; // 雑誌コード

  PageEdit({super.key, required this.startIndex, required this.serachWord})
      : userNameController = TextEditingController(),
        storeNameController = TextEditingController(),
        magazineCodeController = TextEditingController() {
    // 初期化処理
    if (startIndex == 0) {
      storeNameController.text = serachWord;
    } else {
      magazineCodeController.text = serachWord;
    }
  }

  final String title = "編集";

  // 各ページのヒントテキスト
  final String regularHint = "定期先の名称を入力してください";
  final String magazineHint = "雑誌コードを入力してください";
  final String magazineCodeHint = "なんてかこうかな";

  // タブのリスト
  final List<Tab> tabs = const [
    Tab(
      text: '連絡先',
    ),
    Tab(
      text: '雑誌',
    ),
    // Tab(
    //   text: '定期',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    // //画面サイズ
    // var screenSizeWidth = MediaQuery.of(context).size.width;
    // var screenSizeHeight = MediaQuery.of(context).size.height;
    RegularReq regularReq = RegularReq(context: context);
    final regularList = useState<List<LoadRegular>>([]);
    final magazineList = useState<Widget>(const Text("からっぽです"));
    Widget customerList = const Text("検索結果はありません");

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

    // 表示される部分
    List<Widget> children = [
      // 定期先の名称
      TabChildTemplate(editType: 0, icon: Icons.storefront_outlined, hintText: regularHint, controller: storeNameController, nameController: userNameController, child: customerList),
      // 雑誌の名称
      TabChildTemplate(editType: 1, icon: Icons.book_outlined, hintText: magazineHint, controller: magazineCodeController, nameController: userNameController, child: magazineList.value),
      // 定期情報の編集をするページ　ヒントテキストを考える
      // TabChildTemplate(editType: 2, icon: Icons.sell, hintText: magazineCodeHint, controller: magazineCodeController, nameController: userNameController, child: magazineList),
    ];

    // テンプレート呼び出し
    return TabTemplate(
      title: title,
      defaultIndex: startIndex,
      tabList: tabs,
      children: children,
    );
  }
}
