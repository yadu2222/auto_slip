import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditBarView extends StatelessWidget {
  const EditBarView({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.search,
    this.searchIcon = Icons.send,
    this.inputType = TextInputType.text,
    this.inputFormatter = const [],
    this.onChanged,
    this.width = 400,
  });

  final TextEditingController controller;
  final String hintText;
  final double width;

  final IconData icon;
  final IconData searchIcon;
  final void Function()? search;
  final void Function(String)? onChanged;

  final TextInputType inputType; // 数値以外許さないか
  final List<TextInputFormatter> inputFormatter;

  // TODO:サイズエラー解消
  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder _inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0, // 枠線の太さ
      ),
      borderRadius: BorderRadius.circular(30), // 角の丸み
    );

    return Container(
      // width: double.infinity * 0.6, // 横幅を親要素に合わせる
      width: width,
      height: 45,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0), // IconButton との間隔を設定
              child: TextField(
                maxLines: 1,
                keyboardType: inputType,
                inputFormatters: [...inputFormatter],
                // maxLength: maxLength,
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  focusedBorder: _inputBorder,
                  enabledBorder: _inputBorder,
                  // 左側のアイコン
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10), // アイコンの周りに余白を追加
                    child: Icon(icon),
                  ),
                  // 右側のアイコン
                  suffixIcon: search != null
                      ? SizedBox(
                          width: 50, // IconButton の幅を固定
                          child: IconButton(
                            icon: Icon(searchIcon),
                            onPressed: () async {
                              FocusScope.of(context).unfocus(); // キーボードを閉じる
                              search!();
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                onChanged: (value) => {
                  if (onChanged != null) {onChanged!(value)}
                },
                // エンターキーで処理をトリガーする
                onSubmitted: (value) {
                  if (search != null) {
                    FocusScope.of(context).unfocus(); // キーボードを閉じる
                    search!(); // suffixIcon の検索ボタンと同じ処理を呼び出す
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
