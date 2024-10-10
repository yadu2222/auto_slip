import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';
// import 'package:flutter_auto_flip/constant/colors.dart';

import 'package:flutter_auto_flip/view/components/atoms/count_icon.dart';
import '../atoms/item_card.dart';

// お客様情報を表示するカード
class CustomerCard extends StatelessWidget {
  const CustomerCard({
    super.key,
    required this.regularData,
    this.isRed = false,
    required this.onTap,
  });

  final CountingCustomer regularData;
  final bool isRed; // 赤文字表示
  final void Function(CountingCustomer) onTap; // タップ時の処理

  IconData get countIconType {
    switch (regularData.customer.regularType) {
      case 1:
        return CountIconType.delivery.getIcon();
      case 2:
        return CountIconType.store.getIcon();
      case 3:
        return CountIconType.slip.getIcon();
      case 4:
        return CountIconType.library.getIcon();
      case 5:
        return CountIconType.library.getIcon();
      case 6:
        return CountIconType.marucho.getIcon();
      case 7:
        return CountIconType.library.getIcon();
      default:
        return CountIconType.store.getIcon();
    }
  }

  Color get countIconColor {
    switch (regularData.customer.regularType) {
      case 1:
        return CountIconType.delivery.color;
      case 2:
        return CountIconType.store.color;
      case 3:
        return CountIconType.slip.color;
      case 4:
        return CountIconType.library.color;
      case 5:
        return CountIconType.library.color;
      case 6:
        return CountIconType.marucho.color;
      case 7:
        return CountIconType.library.color;
      default:
        return CountIconType.store.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap(regularData),
        child: ItemCard(
            height: 100,
            width: 0.15,
            color: countIconColor,
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(regularData.customer.customerName),
                // Text(regularData.customer.address ?? ''),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(countIconType),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(regularData.regular.quantity.toString())
                ]),
              ],
            )));
  }
}
