import 'package:flutter/material.dart';

class EditForm extends StatelessWidget {
  const EditForm({super.key, this.width = 0.225, this.height, required this.controller, required this.hintText, this.maxLength = 20});

  final double width;
  final double? height;
  final TextEditingController controller;
  final String hintText;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    var screenSizeWidth = MediaQuery.of(context).size.width;
    // var screenSizeHeight = MediaQuery.of(context).size.height;

    return SizedBox(
        width: screenSizeWidth * width,
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
