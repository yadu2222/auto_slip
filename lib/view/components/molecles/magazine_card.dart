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
    this.edit,
    this.icon = Icons.edit,
  });

  final Magazine magazine; // 雑誌情報
  final bool isRed; // 赤文字表示

  final void Function(Magazine)? edit;
  final IconData icon;

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
        InkWell(
            onTap: () {
              if (edit != null) {
                edit!(magazine);
              }
            },
            child: SizedBox(
                child: Icon(
              icon,
              size: 20,
              color: AppColors.iconGlay,
            )))
      ],
    ));
  }
}
