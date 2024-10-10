import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

enum CountIconType {
  book(Icons.menu_book_rounded, '入荷冊数',AppColors.glay),
  library(Icons.local_library_rounded, '図書館',AppColors.library),
  delivery(Icons.delivery_dining, '配達',AppColors.delivery),
  store(Icons.storefront_outlined, '店取',AppColors.store),
  slip(Icons.edit, '店取伝票',AppColors.slip),
  marucho(Icons.local_shipping, '丸長',AppColors.marucho),;

  const CountIconType(this.icon, this.name,this.color);

  final IconData icon;
  final String name;
  final Color color;

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
