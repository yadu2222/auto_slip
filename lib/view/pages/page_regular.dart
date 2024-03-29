import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../data/regular_manager.dart';
import '../parts/parts.dart';

class PageRegular extends StatefulWidget {
  @override
  _PageRegular createState() => _PageRegular();
}

class _PageRegular extends State<PageRegular> {
  // コントローラー
  final _storeNameController = TextEditingController();
  final _magazineController = TextEditingController();
  final _magazineNameController = TextEditingController();

  // どちらで検索しているかを判別する変数
  // 0で店舗名検索、1で雑誌コード検索、2で雑誌名検索
  int searchType = 0;

  @override
  Widget build(BuildContext context) {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;

    // 基本的な数字
    double widthData = 0.6;
    double heightData = 0.1;

    // 表示用のリスト
    List regularList = [];

    // 検索ボタンを押したときの処理
    void serchButtonFunction(int changeType) {
      // 検索タイプの切り替え
      setState(() {
        if (changeType == 0) {
          searchType = 0;
          debugPrint(searchType.toString());
        } else if (changeType == 1) {
          searchType = 1;
          debugPrint(searchType.toString());
        } else {
          searchType = 2;
          debugPrint(searchType.toString());
        }
      });
    }

    // 雑誌名優先表示カード
    Widget magazinesCard(int index) {
      bool isBool = index == 0 || regularList[index]["magazine_code"] != regularList[index - 1]["magazine_code"];
      Widget isWidget = Row(
        children: [
          Text(regularList[index]["magazine_code"].toString()),
          SizedBox(width: screenSizeWidth * 0.02),
          Text(regularList[index]["magazine_name"]),
        ],
      );
      Widget repeatWidget = Row(children: [Text(regularList[index]["store_name"]), SizedBox(width: screenSizeWidth * 0.02), Text(regularList[index]["quantity"].toString() + "冊")]);
      return Parts.dispListCard(isBool, isWidget, repeatWidget, screenSizeWidth, screenSizeHeight,context);
    }

    // 店舗名優先表示カード
    Widget storeListCard(int index) {
      String? regularType = regularList[index]["regular_type"];
      regularType = regularType == "0"
          ? "配達"
          : regularType == "1"
              ? "店取り"
              : regularType == "2"
                  ? "店取り伝票"
                  : "配達";
      String? tellType = regularList[index]["tell_type"];
      tellType = tellType == "0"
          ? "tell不要"
          : tellType == "1"
              ? "tell要"
              : tellType == "2"
                  ? "着信のみ"
                  : "";
      String? address = regularList[index]["address"];
      if (address == null) {
        address = "";
      }

      bool isBool = index == 0 || regularList[index]["store_name"] != regularList[index - 1]["store_name"];
      Widget isWidget = Row(children: [
        Text(regularList[index]["store_name"].toString()),
        SizedBox(width: screenSizeWidth * 0.02),
        Text(address),
        SizedBox(width: screenSizeWidth * 0.02),
        // Text(regularType),
        // SizedBox(width: screenSizeWidth * 0.02),
        Text(tellType)
      ]);
      Widget repeatWidget = Row(children: [
        Text(regularList[index]["magazine_code"].toString()),
        SizedBox(width: screenSizeWidth * 0.02),
        Text(regularList[index]["magazine_name"]),
        SizedBox(width: screenSizeWidth * 0.02),
        Text(regularList[index]["quantity"].toString() + "冊")
      ]);

      return Parts.dispListCard(isBool, isWidget, repeatWidget, screenSizeWidth, screenSizeHeight,context);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('定期一覧'),
        ),
        // DBの読み込みを待ってから表示
        body: Center(
            child: Container(
                child: Column(children: [
          Parts.searchBar(Icons.storefront, "店舗名で検索", _storeNameController, 0, serchButtonFunction),
          Parts.searchBar(Icons.local_offer, "雑誌コードで検索", _magazineController, 1, serchButtonFunction),
          Parts.searchBar(Icons.import_contacts, "誌名で検索", _magazineNameController, 2, serchButtonFunction),
          FutureBuilder(
            future: RegulerManager.getRegularList(
                searchType == 0
                    ? _storeNameController.text
                    : searchType == 1
                        ? _magazineController.text
                        : _magazineNameController.text,
                searchType),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // futureから帰ってきたデータを挿入
                  // Widgetを表示
                  debugPrint(searchType.toString());
                  debugPrint("なにがはいってるのかというと[${searchType == 0 ? _storeNameController.text : _magazineController.text}]");
                  regularList = snapshot.data;
                  print(regularList);
                  return Container(
                      width: screenSizeWidth * widthData,
                      height: screenSizeHeight * heightData * 5,
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        itemCount: regularList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return searchType == 0 ? storeListCard(index) : magazinesCard(index);
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

// 店舗名優先表示カード
    // Widget storeListCard(int index) {
    //   return ListTile(
    //       // 押されたときの動作
    //       // TODO:DB検索と表示
    //       onTap: () async {
    //         // 編集画面に遷移
    //       },
    //       title: Container(
    //         width: screenSizeWidth * widthData,
    //         alignment: Alignment.center,
    //         child: Column(
    //           children: [
    //             index == 0 || regularList[index]["store_name"] == regularList[index - 1]["store_name"]
    //                 ? Container(
    //                     width: screenSizeWidth * widthData * 0.8,
    //                     decoration: const BoxDecoration(
    //                       border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
    //                     ),
    //                     child: Text(
    //                       regularList[index]["store_name"],
    //                     ),
    //                   )
    //                 : SizedBox.shrink(),
    //             Container(
    //                 alignment: Alignment.center,
    //                 child: Row(children: [
    //                   Text(regularList[index]["magazine_code"].toString()),
    //                   SizedBox(width: screenSizeWidth * 0.02),
    //                   Text(regularList[index]["magazine_name"]),
    //                   SizedBox(width: screenSizeWidth * 0.02),
    //                   Text(regularList[index]["quantity"].toString() + "冊")
    //                 ]))
    //           ],
    //         ),
    //       ));
    // }

    // // 雑誌優先表示カード
    // Widget magazinesCard(int index) {
    //   return ListTile(
    //       title: InkWell(
    //           onTap: () {
    //             // 編集画面に遷移
    //           },
    //           child: Container(
    //             width: screenSizeWidth * 0.6,
    //             // height: screenSizeHeight * 0.1,
    //             alignment: Alignment.center,
    //             child: Column(
    //               children: [
    //                 // 一番最初である、または
    //                 // 一つ前のデータと雑誌コードが同一かを判別
    //                 index == 0 || regularList[index]["magazine_code"] != regularList[index - 1]["magazine_code"]
    //                     ? Container(
    //                         width: screenSizeWidth * 0.6,
    //                         decoration: const BoxDecoration(
    //                           border: Border(bottom: BorderSide(width: 1, color: Colors.black)),
    //                         ),
    //                         child: Container(
    //                             alignment: Alignment.center,
    //                             child: Row(
    //                               children: [
    //                                 Text(regularList[index]["magazine_code"].toString()),
    //                                 SizedBox(width: screenSizeWidth * 0.02),
    //                                 Text(regularList[index]["magazine_name"]),
    //                                 // SizedBox(width: screenSizeWidth * 0.02),
    //                                 // Text(regularList[index]["quantity_in_stock"].toString()),
    //                               ],
    //                             )))
    //                     : const SizedBox.shrink(),

    //                 Container(
    //                     alignment: Alignment.center,
    //                     child: Row(children: [
    //                       Text(regularList[index]["store_name"]),
    //                       SizedBox(width: screenSizeWidth * 0.02),
    //                       Text(regularList[index]["quantity"].toString()),
    //                     ]))
    //               ],
    //             ),
    //           )));
    // }

     // Widget searchButton(int changeType) {
    //   return IconButton(
    //       icon: Icon(Icons.send), // Replace 'some_icon' with the desired icon
    //       onPressed: () async {
    //         FocusScope.of(context).unfocus(); //キーボードを閉じる
    //         setState(() {
    //           // 切り替え
    //           if (changeType == 0) {
    //             searchType = 0;
    //             debugPrint(searchType.toString());
    //           } else if (changeType == 1) {
    //             searchType = 1;
    //             debugPrint(searchType.toString());
    //           } else {
    //             searchType = 2;
    //             debugPrint(searchType.toString());
    //           }
    //         });
    //       });
    // }

    // // 検索バー
    // Widget searchBar(IconData icon, String hintText, TextEditingController controller, int addType) {
    //   return // 検索バー
    //       Container(
    //           width: screenSizeWidth * widthData,
    //           //height: screenSizeHeight * 0.067,
    //           decoration: BoxDecoration(color: Color.fromARGB(255, 239, 238, 238), borderRadius: BorderRadius.circular(50)),
    //           margin: EdgeInsets.all(screenSizeWidth * 0.02),
    //           child: Column(children: [
    //             Row(
    //               children: [
    //                 // 検索アイコン
    //                 Container(
    //                     margin: EdgeInsets.only(right: screenSizeWidth * 0.02, left: screenSizeWidth * 0.02),
    //                     child: Icon(
    //                       icon,
    //                       size: 30,
    //                       // color: Colors.grey,
    //                     )),

    //                 Container(
    //                     width: screenSizeWidth * 0.4,
    //                     height: screenSizeHeight * 0.04,
    //                     alignment: const Alignment(0.0, 0.0),
    //                     // テキストフィールド
    //                     child: TextField(
    //                       controller: controller,
    //                       decoration: InputDecoration(
    //                         hintText: hintText,
    //                       ),
    //                       textInputAction: TextInputAction.search,
    //                     )),
    //                 SizedBox(
    //                   width: screenSizeWidth * 0.01,
    //                 ),
    //                 // やじるし 検索ボタン
    //                 searchButton(addType),
    //               ],
    //             )
    //           ]));
    // }
