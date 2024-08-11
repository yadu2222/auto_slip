import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';

import '../molecles/add_magazine_card.dart';
import '../atoms/list_builder.dart';

class AddRegularList extends StatelessWidget {
  const AddRegularList({super.key, required this.regularList, required this.remove});

  final List<CountingRegular> regularList; // 表示する雑誌のリスト

  final void Function(int) remove; // 雑誌を削除する関数

  @override
  Widget build(BuildContext context) {
    return ListBuilder<CountingRegular>(
      itemDatas: regularList,
      listItem: (regular) => AddMagazineCard(
        regular: regular,
        remove: remove,
        index: regularList.indexOf(regular),
      ),
    );
  }
}
