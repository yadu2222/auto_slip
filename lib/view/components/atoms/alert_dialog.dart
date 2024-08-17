import 'package:flutter/material.dart';

class AleatDialogUtil extends StatelessWidget {
  const AleatDialogUtil({super.key, required this.contents, this.height = 400, this.width = 400, this.padding = const EdgeInsets.only(top: 10, left: 40, right: 40, bottom: 10)});

  final double height;
  final double width;
  final EdgeInsets padding;
  final Widget contents;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      content: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: height,
          width: width,
          padding: padding,
          child: contents),
    );
  }
}
