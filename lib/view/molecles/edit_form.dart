import 'package:flutter/material.dart';

class EditForm extends StatelessWidget {
  const EditForm({super.key, this.width, this.height, required this.controller, required this.hintText, this.maxLength = 20});

  final double? width;
  final double? height;
  final TextEditingController controller;
  final String hintText;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: screenSizeWidth * width,
        // height: screenSizeHeight * height,
        alignment: Alignment.center,
        child: TextField(
          enabled: true,
          maxLength: maxLength, // 入力文字数制限
          maxLines: 1,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ));
  }
}
