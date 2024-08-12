import 'package:flutter/material.dart';
// constant
import '../../../constant/colors.dart';
import '../atoms/count_icon.dart';

class CountIcons extends StatelessWidget {
  const CountIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CountIconType.book.getIconInfo(),
        CountIconType.library.getIconInfo(),
        CountIconType.delivery.getIconInfo(),
        CountIconType.store.getIconInfo(),
        CountIconType.slip.getIconInfo(),
        CountIconType.marucho.getIconInfo(),
      ],
    );
  }
}
