import 'package:flutter_auto_flip/view/components/atoms/menu_tile.dart';
import 'package:flutter/material.dart';
import '../molecles/side_menu.dart';

// サイドメニュー
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return const SideMenu(
      menuTileList: [
        // MenuTile(
        //   title: "定期の追加",
        //   movePass: '/add',
        // ),

        MenuTile(
          title: "雑誌",
          movePass: '/magazine',
        ),
        MenuTile(
          title: "顧客",
          movePass: '/customer',
        ),
        MenuTile(
          title: "定期",
          movePass: '/regular',
        ),
        MenuTile(
          title: "数取り",
          movePass: '/',
        ),
        MenuTile(
          title: "設定",
          movePass: '/setting',
        ),
        MenuTile(
          title: "ファイル読み込み",
          movePass: '/test',
        ),
        
      ],
    );
  }
}
