import 'package:flutter/material.dart';

// view
import '../atoms/list_builder.dart';
import '../molecles/regular_card.dart';
import '../atoms/magazine_card.dart';

// model
import '../../models/magazine_model.dart';
import '../../models/regular_model.dart';
import '../../models/load_regular_model.dart';



// 雑誌優先表示リスト
class CountMagazineList extends StatelessWidget {
  const CountMagazineList({
    super.key,
    required this.regularList,
  });

  final LoadRegular regularList; // 表示する定期のリスト

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: regularList.loadRegularList.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> item = regularList.loadRegularList[index]; // 雑誌に対しての定期情報をひとかたまりで取得
          final Magazine magazine = item['magazine'] as Magazine; // 雑誌情報
          final List<Regular> regulars = item['regulars']! as List<Regular>; // 定期情報のリスト
          int regularStock = regulars.length;
          // 冊数比較用の計算
          for (int i = 0; i < regulars.length; i++) {
            regularStock += regulars[i].quantity;
          }
          debugPrint('regularStock: $regularStock');
          return Column(
            children: [
              // 雑誌情報
              MagazineCard(magazine: magazine, isRed: magazine.quantityStock < regularStock),
              // TODO:ここに区切り線
              // 定期情報のリスト
              ListBuilder<Regular>(
                itemDatas: regulars,
                listItem: (regular) => RegularCard(regular: regular),
              ),
            ],
          );
        });
  }
}
