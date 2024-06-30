import 'package:flutter/material.dart';

import '../molecles/add_magazine_card.dart';
import '../../models/regular_model.dart';

class AddRegularList extends StatelessWidget {
  const AddRegularList({super.key, required this.regularList,  required this.remove});

  final List<Regular> regularList; // 表示する雑誌のリスト

  final void Function(int) remove; // 雑誌を削除する関数

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: regularList.length,
        itemBuilder: (context, index) {
          return AddMagazineCard(
                  regular: regularList[index],
                  remove: remove,
                  index: index,
                );
        });
  }
}
