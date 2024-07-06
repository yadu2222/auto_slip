import 'package:flutter/material.dart';

import '../molecles/edit_bar.dart' as edit;
import '../atoms/basic_button.dart';

class TabChildTemplate extends StatelessWidget {
  const TabChildTemplate({super.key, required this.editType, required this.icon, required this.hintText, required this.child, required this.controller,required this.nameController});

  final int editType;
  final Widget child;
  final IconData icon;
  final String hintText;
  final TextEditingController nameController;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          edit.EditBarView(
              // 名前の入力
              controller: nameController,
              hintText: 'あなたの名前はなんですか',
              icon: Icons.edit,
              ),
          // 検索バー
          edit.EditBarView(
            icon: icon,
            hintText: hintText,
            controller: controller,
            search: () {},
          ),
          child,
          BasicButton(text: "確定", isColor: true, onPressed: () {})

        ],
      ),
    );
  }
}
