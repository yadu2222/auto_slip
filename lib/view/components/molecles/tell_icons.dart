import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/view/components/atoms/tell_icon.dart';

class TellIcons extends StatelessWidget {
  const TellIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TellIconType.essential.getIconInfo(),
        TellIconType.unnecessary.getIconInfo(),
        TellIconType.call.getIconInfo(),
      ],
    );
  }
}