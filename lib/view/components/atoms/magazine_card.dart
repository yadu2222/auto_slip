import 'package:flutter/material.dart';
import '../../../models/magazine_model.dart';
import 'item_card.dart';

class MagazineCard extends StatelessWidget {
  const MagazineCard({super.key, required this.magazine, required this.isRed});

  final Magazine magazine; // 表示する雑誌情報
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        widget: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(magazine.magazineCode),
        Text(magazine.magazineName),
        Text(magazine.quantityStock.toString(), style: TextStyle(color: isRed ? Colors.red : Colors.black)),
      ],
    ));
  }
}
