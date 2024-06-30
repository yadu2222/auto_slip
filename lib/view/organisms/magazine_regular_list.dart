import 'package:flutter/material.dart';

// view
import '../atoms/list_builder.dart';
import '../molecles/regular_card.dart';
import '../atoms/magazine_card.dart';

// model
import '../../models/magazine_model.dart';
import '../../models/regular_model.dart';
import '../../models/load_regular_model.dart';

class MagazineRegularList extends StatelessWidget {
  const MagazineRegularList({
    super.key,
    required this.regularList,
  });

  final LoadRegular regularList; // 表示する定期のリスト


  // 顧客優先表示リスト
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: regularList.loadRegularList.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> item = regularList.loadRegularList[index]; // 雑誌に対しての定期情報をひとかたまりで取得
          final List<Magazine> magazines = item['magazines'] as List<Magazine>; // 雑誌情報
          final Regular regular = item['regular']! as Regular; // 定期情報のリスト
          
          return Column(
            children: [
              // 顧客情報
              RegularCard(regular: regular,isQuantity: false),
              // TODO:ここに区切り線
              // 雑誌のリスト
              ListBuilder<Magazine>(
                itemDatas: magazines,
                listItem: (magazine) => MagazineCard(magazine: magazine,isRed: false,),
              ),
            ],
          );
        });
  }
}
