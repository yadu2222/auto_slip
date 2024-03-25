import 'package:flutter/material.dart';

class Parts {
  static Widget searchBar(
    IconData icon,
    String hintText,
    TextEditingController controller,
    int addType,
    Function function,
  ) {
    return SearchBar(icon: icon, hintText: hintText, controller: controller, addType: addType, function: function);
  }

  static Widget dispListCard(bool isdisp, Widget iswidget, Widget repeatWidget, double screenSizeWidth, double screenSizeHeight) {
    return DispCard.dispListCard(isdisp, iswidget, repeatWidget, screenSizeWidth, screenSizeHeight);
  }
}

// 検索バー
class SearchBar extends StatefulWidget {
  IconData icon;
  String hintText;
  TextEditingController controller;
  int addType;
  Function function;
  SearchBar({Key? key, required this.icon, required this.hintText, required this.controller, required this.addType, required this.function}) : super(key: key);

  @override
  _SearchBar createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;

    // 受け取った変数を再定義
    int addType = widget.addType;
    IconData icon = widget.icon;
    TextEditingController controller = widget.controller;
    String hintText = widget.hintText;

    // 検索ボタン
    Widget searchButton() {
      return IconButton(
          icon: const Icon(Icons.send),
          onPressed: () async {
            FocusScope.of(context).unfocus(); //キーボードを閉じる
            // 押したときの処理
            widget.function(addType);
          });
    }

    return Container(
        width: screenSizeWidth * 0.6,
        //height: screenSizeHeight * 0.067,
        decoration: BoxDecoration(color: Color.fromARGB(255, 239, 238, 238), borderRadius: BorderRadius.circular(50)),
        margin: EdgeInsets.all(screenSizeWidth * 0.02),
        child: Column(children: [
          Row(
            children: [
              // 検索アイコン
              Container(
                  margin: EdgeInsets.only(right: screenSizeWidth * 0.02, left: screenSizeWidth * 0.02),
                  child: Icon(
                    icon,
                    size: 30,
                    // color: Colors.grey,
                  )),

              Container(
                  width: screenSizeWidth * 0.4,
                  height: screenSizeHeight * 0.04,
                  alignment: const Alignment(0.0, 0.0),
                  // テキストフィールド
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hintText,
                    ),
                    textInputAction: TextInputAction.search,
                  )),
              SizedBox(
                width: screenSizeWidth * 0.01,
              ),
              // やじるし 検索ボタン
              searchButton(),
            ],
          )
        ]));
  }
}

class DispCard {
  // 表示するindex、表示するかの条件、その際表示するウィジェット、繰り返すウィジェット、画面サイズ
  static Widget dispListCard(bool isdisp, Widget iswidget, Widget repeatWidget, double screenSizeWidth, double screenSizeHeight) {
    return ListTile(
        title: InkWell(
            onTap: () {
              // 編集画面に遷移
            },
            child: Container(
              width: screenSizeWidth * 0.9,
              alignment: Alignment.center,
              child: Column(
                children: [
                  // 見出し
                  isdisp
                      ? Container(
                          width: screenSizeWidth * 0.9,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
                          ),
                          child: Container(child: iswidget))
                      : const SizedBox.shrink(),
                  // 繰り返し表示するウェジェット
                  Container(alignment: Alignment.center, child: repeatWidget)
                ],
              ),
            )));
  }
}
