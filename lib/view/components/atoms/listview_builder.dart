import 'package:flutter/material.dart';

class ListViewBuilder<Model> extends StatelessWidget {
  const ListViewBuilder({
    super.key,
    this.height,
    required this.itemDatas,
    required this.listItem,
    this.horizontal = false,
  });

  final double? height; // 高さ
  final List<Model> itemDatas; // リストデータ
  final Widget Function(Model item) listItem; // カード ウィジェット関数
  final bool horizontal; // 横スクロール

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        height: height != null ? MediaQuery.of(context).size.height * height! : null,
        child: MediaQuery.removePadding(
            // これでラップすると余白が削除される
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListView.builder(
              scrollDirection: horizontal ? Axis.horizontal : Axis.vertical,
              itemCount: itemDatas.length,
              itemBuilder: (BuildContext context, int index) {
                return listItem(itemDatas[index]);
              },
            )));
  }
}
