import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

enum TellIconType {

  essential(Icons.phone_enabled, '要'),
  unnecessary(Icons.phone_disabled_rounded, '不要'),
  call(Icons.phone_callback_rounded,'着信のみ');

  const TellIconType(this.icon, this.name);

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
