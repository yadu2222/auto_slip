import 'package:flutter/material.dart';
import '../../../constant/colors.dart';

class DropDownUtil extends StatelessWidget {
  const DropDownUtil({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint,
    this.height = 50,
    this.width = 400,
  });

  final List<Map<String, dynamic>> items; // 表示するリスト
  final Function(int?) onChanged;
  final int? value; // 初期値
  final String? hint;
  final double height;
  final double width ;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        // margin: const EdgeInsets.only(top: 20),
        height: height,
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(50)), border: Border.all(color: AppColors.iconGlay)),
        child: DropdownButton<int>(
          value: value,
          hint: hint != null
              // hinttext
              ? Text(
                  hint!,
                )
              : null,
          icon: const SizedBox.shrink(),
          iconSize: 24,
          style: const TextStyle(color: AppColors.font),
          dropdownColor: AppColors.iconLight,
          onChanged: onChanged,
          underline: Container(),
          items: items.map<DropdownMenuItem<int>>((Map<String, dynamic> item) {
            return DropdownMenuItem<int>(
                value: item['value'],
                child: Row(
                  children: [
                    Icon(item['icon']),
                    const SizedBox(width: 10),
                    Text(item['display']),
                  ],
                ));
          }).toList(),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          focusColor: Colors.transparent,
        ));
  }
}
