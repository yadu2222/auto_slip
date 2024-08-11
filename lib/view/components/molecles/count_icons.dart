import 'package:flutter/material.dart';
// constant
import '../../../constant/colors.dart';

class CountIcons extends StatelessWidget {
  const CountIcons({super.key});

  @override
  Widget build(BuildContext context) {
    Widget countIcon(IconData icon, String name, {Color color = AppColors.iconGlay, bool isSpace = true}) {
      return Row(
        children: [
          Icon(
            icon,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(name),
          if (isSpace) const SizedBox(width: 10),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        countIcon(Icons.menu_book_rounded, '入荷冊数'),
        countIcon(Icons.local_library_sharp, '図書館'),
        countIcon(Icons.delivery_dining, '配達'),
        countIcon(Icons.storefront_outlined, '店取'),
        countIcon(Icons.edit, '店取伝票'),
        countIcon(Icons.local_shipping, '丸長'),
      ],
    );
  }
}
