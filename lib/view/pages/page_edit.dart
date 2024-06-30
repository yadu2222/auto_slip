import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// view
import '../template/tab_template.dart';
import '../template/tab_child_template.dart';
import '../organisms/regular_customer_list.dart';
import '../organisms/regular_magazine_list.dart';

// mode;
import '../../models/load_regular_model.dart';
// sample
// import '../../constant/sample_data.dart';

class PageEdit extends HookWidget {
  // TODO:遷移前から編集対象のidをもらってくる？
  PageEdit({super.key});

  final TextEditingController userNameController = TextEditingController(); // 編集者の名前
  final TextEditingController storeNameController = TextEditingController(); // 店舗名
  final TextEditingController magazineNameController = TextEditingController(); // 雑誌名
  final TextEditingController magazineCodeController = TextEditingController(); // 雑誌コード

  final String title = "編集";

  // 各ページのヒントテキスト
  final String regularHint = "定期先の名称を入力してください";
  final String magazineHint = "雑誌名を入力してください";
  final String magazineCodeHint = "なんてかこうかな";

  // タブのリスト
  final List<Tab> tabs = const [
    Tab(
      text: '連絡先',
    ),
    Tab(
      text: '雑誌',
    ),
    Tab(
      text: '定期',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // //画面サイズ
    // var screenSizeWidth = MediaQuery.of(context).size.width;
    // var screenSizeHeight = MediaQuery.of(context).size.height;
    final regularList = useState<LoadRegular?>(null);

    Widget customerList = regularList.value == null ? const Text("検索結果はありません") : RegularCustomerList(regularList: regularList.value!);
    Widget magazineList = regularList.value == null ? const Text("検索結果はありません") : RegularMagazineList(regularList: regularList.value!);

    // 表示される部分
    List<Widget> children = [
      // 定期先の名称
      TabChildTemplate(
        editType: 0,
        icon: Icons.storefront_outlined,
        hintText: regularHint,
        controller: storeNameController,
        nameController: userNameController,
        child: customerList
      ),
      // 雑誌の名称
      TabChildTemplate(
        editType: 1,
        icon: Icons.book_outlined,
        hintText: magazineHint,
        controller: magazineNameController,
        nameController: userNameController,
        child: magazineList
      ),
      // 定期情報の編集をするページ　ヒントテキストを考える
      TabChildTemplate(
        editType: 2,
        icon: Icons.sell,
        hintText: magazineCodeHint,
        controller: magazineCodeController,
        nameController: userNameController,
        child: magazineList
      ),
    ];

    // テンプレート呼び出し
    return TabTemplate(
      title: title,
      defaultIndex: 0,
      tabList: tabs,
      children: children,
    );
  }
}
