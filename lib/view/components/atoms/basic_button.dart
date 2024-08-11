import 'package:flutter/material.dart';
import '../../../constant/colors.dart';
import '../../../constant/fonts.dart';


class BasicButton extends StatelessWidget {
  const BasicButton({
    super.key,
    required this.text,
    this.icon,
    required this.isColor, // trueでみどり falseで赤
    this.onPressed,
    this.height = 35.0,
    this.circular = 10,
    this.width = 150,
  });

  final String text;
  final IconData? icon;
  final bool isColor;
  final double height;
  final double width;
  final double circular;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 5, bottom: 15),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: isColor ? AppColors.subjectScience : AppColors.subjectJapanese,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circular) //こちらを適用
                    )),
            onPressed: onPressed,
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              icon != null ? Icon(icon, color: AppColors.iconLight, size: 30) : const SizedBox.shrink(),
              Expanded(
                  child: Container(
                      alignment: Alignment.center, // 残りのスペースの中央に配置
                      child: Text(
                        text,
                        style: Fonts.h5w,
                      )))
            ])));
  }
}
