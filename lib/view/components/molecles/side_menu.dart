import 'package:flutter_auto_flip/view/components/atoms/menu_tile.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key,required this.menuTileList});

  final List<MenuTile> menuTileList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Expanded(
          child: ListView(
            children: [...menuTileList],
          ),
        ));
  }
}
