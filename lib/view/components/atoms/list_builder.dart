import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/view/components/atoms/listview_builder.dart';
import 'package:flutter_auto_flip/view/components/atoms/no_resource.dart';

class ListBuilder<Model> extends StatelessWidget {
  const ListBuilder({
    super.key,
    this.height,
    required this.itemDatas,
    required this.listItem,
    this.onTap,
    this.onRefresh,
    this.horizontal = false,
  });

  final double? height; // 高さ
  final List<Model> itemDatas; // リストデータ
  final Widget Function(Model item) listItem; // カード ウィジェット関数
  final void Function(int index)? onTap; // タップ時の処理 indexに合わせて処理を行いたければここに記述 そうでなければlistItem時点で記述しても良い
  final void Function()? onRefresh; // スクロールで再取得
  final bool horizontal; // 横スクロール

  // スクロールで再取得

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
            onRefresh: () async {
              if (onRefresh != null) {
                onRefresh!();
              }
            },
            child: itemDatas.isEmpty
                ? const NoResources()
                : ListViewBuilder(itemDatas: itemDatas, listItem: listItem,height: height,horizontal: horizontal,)));
  }
}
