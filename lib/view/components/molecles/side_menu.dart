import 'package:flutter_auto_flip/view/components/atoms/menu_tile.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key,required this.menuTileList});

  final List<MenuTile> menuTileList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,    // 画面いっぱいに表示
        width: 200,
          child: ListView(
            children: [...menuTileList],
          ),
        );
  }
}
