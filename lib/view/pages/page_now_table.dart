import 'package:flutter/material.dart';
import '../../data/regular_manager.dart';

class PageNowTable extends StatefulWidget {
  @override
  _PageNowTableState createState() => _PageNowTableState();
}

class _PageNowTableState extends State<PageNowTable> {
  // コントローラー
  final _storeNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;

    // 基本的な数字
    double widthData = 0.6;
    double heightData = 0.1;

    // 表示用のリスト
    List storeList = [];

    Widget searchButton(String serchRoom) {
      return IconButton(
          icon: Icon(Icons.send), // Replace 'some_icon' with the desired icon
          onPressed: () async {
            FocusScope.of(context).unfocus(); //キーボードを閉じる

            // List newList = await RegulerManager.getSerchData(serchRoom);

            setState(() {});
          });
    }

    // 検索バー
    Widget serchBar() {
      return // 検索バー
          Container(
              width: screenSizeWidth * widthData,
              //height: screenSizeHeight * 0.067,
              decoration: BoxDecoration(color: Color.fromARGB(255, 239, 238, 238), borderRadius: BorderRadius.circular(50)),
              margin: EdgeInsets.all(screenSizeWidth * 0.02),
              child: Column(children: [
                Row(
                  children: [
                    // 検索アイコン
                    Container(
                        margin: EdgeInsets.only(right: screenSizeWidth * 0.02, left: screenSizeWidth * 0.02),
                        child: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        )),

                    Container(
                        width: screenSizeWidth * 0.4,
                        height: screenSizeHeight * 0.04,
                        alignment: const Alignment(0.0, 0.0),
                        // テキストフィールド
                        child: TextField(
                          controller: _storeNameController,
                          decoration: const InputDecoration(
                            hintText: '店舗名を入力してください',
                          ),
                          textInputAction: TextInputAction.search,
                        )),
                    SizedBox(
                      width: screenSizeWidth * 0.01,
                    ),
                    // やじるし 検索ボタン
                    searchButton(_storeNameController.text),
                  ],
                )
              ]));
    }

    // 店舗リストのカード
    Widget storeListCard(int index) {
      return ListTile(
          // 押されたときの動作
          // TODO:DB検索と表示
          onTap: () async {},
          title: Container(
            width: screenSizeWidth * widthData,
            alignment: Alignment.center,
            child: Column(
              children: [
                index == 0
                    ? Container(
                        width: screenSizeWidth * widthData * 0.8,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
                        ),
                        child: Text(
                          storeList[index]["store_name"],
                        ),
                      )
                    : storeList[index]["store_name"] == storeList[index - 1]["store_name"]
                        ? const SizedBox.shrink()
                        : Container(
                            width: screenSizeWidth * widthData * 0.8,
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
                            ),
                            child: Text(
                              storeList[index]["store_name"],
                            ),
                          ),
                Container(
                    alignment: Alignment.center,
                    child: Row(children: [Text(storeList[index]["magazine_code"].toString()), SizedBox(width: screenSizeWidth * 0.02), Text(storeList[index]["magazine_name"])]))
              ],
            ),
          ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('定期一覧'),
        ),
        // DBの読み込みを待ってから表示
        body: Center(
            child: Container(
                child: Column(children: [
          serchBar(),
          FutureBuilder(
            future: RegulerManager.getStoreList(_storeNameController.text),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // futureから帰ってきたデータを挿入
                  // Widgetを表示
                  debugPrint("なにがはいってるのかというと[${_storeNameController.text}]");
                  storeList = snapshot.data;
                  return Container(
                      width: screenSizeWidth * widthData * 0.8,
                      height: screenSizeHeight * heightData * 6,
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        itemCount: storeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return storeListCard(index);
                        },
                      ));
                }
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ]))));
  }

  @override
  void dispose() {
    // Stateがdisposeされる際に、TextEditingControllerも破棄する
    _storeNameController.dispose();
    super.dispose();
  }
}
