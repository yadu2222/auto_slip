import 'package:flutter/material.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({super.key, required this.controller, required this.hintText, required this.icon, this.search,this.isSearch = true});

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool isSearch;
  final void Function()? search;

  // TODO:サイズエラー解消
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity * 0.6, // 横幅を親要素に合わせる
      width: 400,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0), // IconButton との間隔を設定
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  icon: Icon(icon),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),

          isSearch ?
          SizedBox(
            width: 50, // IconButton の幅を固定
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () async {
                FocusScope.of(context).unfocus(); // キーボードを閉じる
                search != null ? search!() : null;
              },
            ),
          ) : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
