import 'package:flutter/material.dart';
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
                : SizedBox(
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
                        )))));
  }
}
