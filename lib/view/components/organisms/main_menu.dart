import 'package:flutter_auto_flip/view/components/atoms/menu_tile.dart';
import 'package:flutter/material.dart';
import '../molecles/side_menu.dart';



// サイドメニュー
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return  const SideMenu(
      menuTileList: [
        MenuTile(
          title: "定期の追加",
          movePass: '/home/add',
        ),
        MenuTile(
          title: "現在の定期一覧",
          movePass: '/home/show',
        ),
        MenuTile(
          title: "数取り",
          movePass: '/home/count',
        ),
        MenuTile(
          title: "てすと",
          movePass: '/home/test',
        ),
      ],
    );
  }
}
