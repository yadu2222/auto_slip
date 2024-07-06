import 'package:flutter/material.dart';

// view
import '../atoms/list_builder.dart';
import '../molecles/regular_card.dart';
import '../atoms/magazine_card.dart';

// model
import '../../../models/magazine_model.dart';
import '../../../models/regular_model.dart';
import '../../../models/load_regular_model.dart';

class RegularList extends StatelessWidget {
  const RegularList.headerMagazine({super.key, required this.regularList, this.isCustomer = false});
  const RegularList.headerCustomer({
    super.key,
    required this.regularList,
    this.isCustomer = true,
  });

  final bool isCustomer; // どちらを優先して表示するか
  final LoadRegular? regularList; // 表示する定期のリスト

  // 顧客優先表示リスト
  @override
  Widget build(BuildContext context) {

    // nullを判別
    return regularList == null
        ? const Center(child: Text('からっぽです'))
        : isCustomer
            ?
            // 顧客を見出しにする
            ListView.builder(
                itemCount: regularList!.loadRegularList.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> item = regularList!.loadRegularList[index]; // 雑誌に対しての定期情報をひとかたまりで取得
                  final List<Magazine> magazines = item['magazines'] as List<Magazine>; // 雑誌情報
                  final Regular regular = item['regular']! as Regular; // 定期情報のリスト

                  return Column(
                    children: [
                      // 顧客情報
                      RegularCard(regular: regular, isQuantity: false),
                      // TODO:ここに区切り線
                      // 雑誌のリスト
                      ListBuilder<Magazine>(
                        itemDatas: magazines,
                        listItem: (magazine) => MagazineCard(
                          magazine: magazine,
                          isRed: false,
                        ),
                      ),
                    ],
                  );
                })
            :
            // 雑誌を見出しにする
            ListView.builder(
                itemCount: regularList!.loadRegularList.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> item = regularList!.loadRegularList[index]; // 雑誌に対しての定期情報をひとかたまりで取得
                  final Magazine magazine = item['magazine'] as Magazine; // 雑誌情報
                  final List<Regular> regulars = item['regulars']! as List<Regular>; // 定期情報のリスト

                  return Column(
                    children: [
                      // 雑誌情報
                      MagazineCard(magazine: magazine, isRed: false),
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
