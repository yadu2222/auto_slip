import 'package:flutter/material.dart';
// constant
import '../atoms/count_icon.dart';

class CountIcons extends StatelessWidget {
  const CountIcons({super.key, this.book = true});

  final bool book;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        book ? CountIconType.book.getIconInfo() : const SizedBox.shrink(),
        CountIconType.library.getIconInfo(),
        CountIconType.delivery.getIconInfo(),
        CountIconType.store.getIconInfo(),
        CountIconType.slip.getIconInfo(),
        CountIconType.marucho.getIconInfo(),
      ],
    );
  }
}
