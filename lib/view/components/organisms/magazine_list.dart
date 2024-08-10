import 'package:flutter/material.dart';
// view
import '../atoms/list_builder.dart';
import '../molecles/magazine_card.dart';
// model
import '../../../models/magazine_model.dart';

// 雑誌をカウントして表示
class MagazineList extends StatelessWidget {
  const MagazineList({
    super.key,
    required this.magazines,
    required this.onRefresh,
    
  });

  final List<Magazine> magazines; // 表示する定期のリスト
  final void Function() onRefresh; // スクロールで再取得

  @override
  Widget build(BuildContext context) {
    return ListBuilder<Magazine>(
      onRefresh: onRefresh,
      itemDatas: magazines,
      listItem: (item) => MagazineCard(magazine: item),
    );
  }
}
