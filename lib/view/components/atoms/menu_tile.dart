import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({super.key, required this.title, required this.movePass});

  final String title;
  final String movePass;

  // 設定したパスに遷移するタイル
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        context.go(movePass);
      },
    );
  }
}