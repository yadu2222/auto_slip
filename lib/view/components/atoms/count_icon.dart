import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

enum CountIconType {
  book(Icons.menu_book_rounded, '入荷冊数'),
  library(Icons.local_library_rounded, '図書館'),
  delivery(Icons.delivery_dining, '配達'),
  store(Icons.storefront_outlined, '店取'),
  slip(Icons.edit, '店取伝票'),
  marucho(Icons.local_shipping, '丸長');

  const CountIconType(this.icon, this.name);

  final IconData icon;
  final String name;

  IconData getIcon() {
    return icon;
  }

  Widget getIconInfo({Color color = AppColors.iconGlay, bool isSpace = true, void Function()? onTap}) {
    return InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: 5),
            Text(name),
            if (isSpace) const SizedBox(width: 10),
          ],
        ));
  }
}
