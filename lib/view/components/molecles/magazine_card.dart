import 'package:flutter/material.dart';
import '../atoms/item_card.dart';
import '../../../models/magazine_model.dart';

// 雑誌情報を表示するカード
class MagazineCard extends StatelessWidget {
  const MagazineCard({
    super.key,
    required this.magazine,
    this.isRed = false,
  });

  final Magazine magazine; // 雑誌情報
  final bool isRed; // 赤文字表示

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        widget: Row(
      children: [
        Text(magazine.magazineCode),
        SizedBox(width: 10),
        Text(magazine.magazineName),
      ],
    ));
  }
}
