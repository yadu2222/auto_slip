import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';

import 'item_card.dart';

class MagazineCard extends StatelessWidget {
  const MagazineCard({
    super.key,
    required this.magazine,
  });

  final CountingRegular magazine; // 表示する雑誌情報

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        widget: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Text(magazine.magazine.magazineCode),
          const SizedBox(width: 10),
          Text(magazine.magazine.magazineName),
        ]),
        Text("${magazine.regular.quantity.toString()}冊"),
      ],
    ));
  }
}
