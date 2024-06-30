import 'package:flutter/material.dart';

class ListBuilder<Model> extends StatelessWidget {
  const ListBuilder({
    super.key,
    this.height,
    required this.itemDatas,
    required this.listItem,
    this.onTap,
  });

  final double? height; // 高さ
  final List<Model> itemDatas; // リストデータ
  final Widget Function(Model item) listItem; // カード ウィジェット関数
  final void Function(int index)? onTap; // タップ時の処理 indexに合わせて処理を行いたければここに記述 そうでなければlistItem時点で記述しても良い

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.92,
      height: height != null ? MediaQuery.of(context).size.height * height! : null,
      // child: ListView.builder(
      //   itemCount: itemDatas.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return listItem(itemDatas[index]);
      //   },
      // ));

      // 空白に対応
      child: SingleChildScrollView(
          child: Column(
              children: itemDatas.asMap().entries.map((entry) {
        final index = entry.key; // インデックス
        final item = entry.value; // アイテム
        return InkWell(
            onTap: () {
              // nullチェック
              if (onTap != null) {
                onTap!(index);
              }
            },
            child: listItem(item));
      }).toList())),
    );
  }
}
