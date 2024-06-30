import 'package:flutter/material.dart';

import '../molecles/add_magazine_card.dart';
import '../../models/magazine_model.dart';

class AddRegularList extends StatelessWidget {
  const AddRegularList({super.key, required this.magazineList,  required this.remove});

  final List<Magazine> magazineList; // 表示する雑誌のリスト

  final void Function(int) remove; // 雑誌を削除する関数

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: magazineList.length,
        itemBuilder: (context, index) {
          return AddMagazineCard(
                  magazine: magazineList[index],
                  remove: remove,
                  index: index,
                );
        });
  }
}
