import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auto_flip/constant/colors.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
import '../atoms/item_card.dart';

// 雑誌情報を表示するカード
class CountingCard extends StatelessWidget {
  const CountingCard({
    super.key,
    required this.countData,
    this.isRed = false,
    required this.onTap,
  });

  final Counting countData; // 雑誌情報
  final bool isRed; // 赤文字表示
  final void Function(Counting) onTap; // タップ時の処理

  @override
  Widget build(BuildContext context) {
    Widget countIcon(IconData icon, int count, {Color color = AppColors.iconGlay, bool isSpace = true}) {
      return Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(count.toString()),
          if (isSpace) const SizedBox(width: 10),
        ],
      );
    }

    return ItemCard(
        widget: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ひだりがわ
        Row(children: [
          Text(countData.magazine.magazineCode),
          const SizedBox(width: 10),
          Text(countData.magazine.magazineName),
          const SizedBox(width: 10),
          Text(countData.magazine.number!),
        ]),

        // みぎがわ
        Row(children: [
          // 入荷冊数
          Icon(
            Icons.menu_book_rounded,
            color: countData.countingFlag ? AppColors.iconGlay : AppColors.buttonCheck,
          ),
          const SizedBox(width: 5),
          Text(
            countData.magazine.quantityStock.toString(),
            style: countData.countingFlag ? null : const TextStyle(color: AppColors.buttonCheck),
          ),
          const SizedBox(width: 20),

          countIcon(Icons.local_library_sharp, countData.count.library), // 図書館
          countIcon(Icons.delivery_dining, countData.count.delivery), // 郵送
          countIcon(Icons.storefront_outlined, countData.count.store), // 店取
          countIcon(Icons.edit, countData.count.slip), // 店取伝票
          countIcon(Icons.local_shipping, countData.count.hauler, isSpace: false), // 運送屋さん
        ])
      ],
    ));
  }
}
