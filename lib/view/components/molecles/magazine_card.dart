import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/constant/colors.dart';
import '../atoms/item_card.dart';
import '../../../models/magazine_model.dart';

// 雑誌情報を表示するカード
class MagazineCard extends StatelessWidget {
  const MagazineCard({
    super.key,
    required this.magazine,
    this.isRed = false,
    required this.onTap,
  });

  final Magazine magazine; // 雑誌情報
  final bool isRed; // 赤文字表示
  final void Function(Magazine) onTap; // タップ時の処理

  @override
  Widget build(BuildContext context) {
    return ItemCard(
        widget: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Text(magazine.magazineCode),
          const SizedBox(width: 10),
          Text(magazine.magazineName),
        ]),
        IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              onTap(magazine);
            },
            icon: const Icon(
              Icons.edit,
              size: 20,
              color: AppColors.iconGlay,
            ))
      ],
    ));
  }
}
