import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/constant/colors.dart';

class EditBarView extends StatelessWidget {
  const EditBarView({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.maxLength = 20,
    this.search,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLength;
  final IconData icon;
  final void Function()? search;

  // TODO:サイズエラー解消
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity * 0.6, // 横幅を親要素に合わせる
      width: 400,
      height: 45,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0), // IconButton との間隔を設定
              child: TextField(
                // maxLength: maxLength,
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
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
                            icon: const Icon(Icons.send),
                            onPressed: () async {
                              FocusScope.of(context).unfocus(); // キーボードを閉じる
                              search!();
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.glay, width: 2.0),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
