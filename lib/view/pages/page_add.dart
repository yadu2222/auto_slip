import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../apis/controller/regular_manager.dart';

import '../parts/molecules.dart';

class PageAdd extends StatefulWidget {
  @override
  _PageAddState createState() => _PageAddState();
}

class _PageAddState extends State<PageAdd> {
  // 入力された内容を保持するコントローラ
  TextEditingController storeController = TextEditingController();
  TextEditingController magazineController = TextEditingController();
  TextEditingController magezineNumController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  String addType = "定期";

  List addMagezens = [
    // {
    //   "magazineCode": "雑誌コード",
    //   "magazineName": "誌名",
  ]; // 追加する定期の表示表変数
  String storeName = "";

  // 画面サイズ
  double widthData = 0.6;
  double heightData = 0.1;

  // 店舗名の入力
  Widget editStore() {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenSizeWidth * widthData,
      height: screenSizeHeight * heightData,
      alignment: Alignment.center,
      child: TextField(
        enabled: true,
        maxLength: 20,
        maxLines: 1,
        controller: storeController,
        decoration: const InputDecoration(
          hintText: '店舗名',
        ),
      ),
    );
  }

  // 定期情報の入力
  Widget editData() {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;
    // 幅
    var width = screenSizeWidth * widthData;
    var height = screenSizeHeight * heightData;
    return // 定期情報の入力
        Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: Row(
        children: [
          // 雑誌コード
          Container(
            width: screenSizeWidth * 0.225,
            height: height,
            alignment: Alignment.center,
            child: TextField(
              enabled: true,
              maxLength: 10,
              maxLines: 1,
              controller: magezineNumController,
              decoration: const InputDecoration(
                hintText: '雑誌コード',
              ),
            ),
          ),
          SizedBox(
            width: screenSizeWidth * 0.05,
            height: screenSizeHeight * 0.1,
          ),
          // 雑誌名
          Container(
              width: screenSizeWidth * 0.225,
              height: height,
              alignment: Alignment.center,
              child: TextField(
                enabled: true,
                maxLength: 20,
                maxLines: 1,
                controller: magazineController,
                decoration: const InputDecoration(
                  hintText: '雑誌名',
                ),
              )),
          SizedBox(
            width: screenSizeWidth * 0.05,
            height: screenSizeHeight * 0.1,
          ),
          // 数量
          Container(
              width: screenSizeWidth * 0.05,
              height: height,
              alignment: Alignment.center,
              child: TextField(
                enabled: true,
                maxLength: 2,
                maxLines: 1,
                controller: quantityController,
                decoration: const InputDecoration(
                  hintText: '数量',
                ),
              ))
        ],
      ),
    );
  }

  // 追加中の定期リスト
  Widget regularList() {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;
    // 幅
    var width = screenSizeWidth * widthData;
    var height = screenSizeHeight * heightData;
    return SizedBox(
      width: width * 1.1,
      height: height * 5,
      child: ListView.builder(
          itemCount: addMagezens.length + 1,
          itemBuilder: (context, index) {
            return index == 0 ? addMagazineButton() : addMagazine(index - 1);
          }),
    );
  }

  // 追加する定期の雛形
  Widget addMagazine(int index) {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;
    return Card(
        // color: Constant.glay.withAlpha(0),
        //           elevation: 0,
        elevation: 0,
        child: SizedBox(
          width: screenSizeWidth * widthData,
          height: screenSizeHeight * 0.075,
          child: Row(
            children: [
              // 削除ボタン
              IconButton(
                  onPressed: () {
                    setState(() {
                      addMagezens.removeAt(index);
                    });
                  },
                  icon: const Icon(
                    Icons.horizontal_rule,
                    color: Colors.black,
                    size: 20,
                  )),
              // 情報の表示
              Container(width: screenSizeWidth * 0.225, height: screenSizeHeight * 0.1, alignment: Alignment.center, child: Text(addMagezens[index]["magazineCode"])),
              Container(width: screenSizeWidth * 0.225, height: screenSizeHeight * 0.1, alignment: Alignment.center, child: Text(addMagezens[index]["magazineName"])),
              Container(width: screenSizeWidth * 0.15, height: screenSizeHeight * 0.1, alignment: Alignment.center, child: Text(addMagezens[index]["quantity"]))
            ],
          ),
        ));
  }

  Widget addMagazineButton() {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenSizeWidth * widthData,
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              // 入力されていなければ弾く
              if (magazineController.text != "" && magezineNumController.text != "") {
                // 入力していた情報をリストに追加
                Map<String, String> addMag = {"magazineCode": magezineNumController.text, "magazineName": magazineController.text, "quantity": quantityController.text};
                setState(() {
                  // 追加
                  addMagezens.add(addMag);
                  // 店名の更新
                  storeName = storeController.text;
                });
                magazineController.clear();
                magezineNumController.clear();
                quantityController.clear();
              }
            },
            child: const Icon(
              Icons.add,
              color: Colors.black,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

  // 定期追加確定ボタン
  Widget addRegularButton() {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () async {
        // 条件確認
        bool isStore = storeController.text != "";
        bool isMagazine = addMagezens.isNotEmpty;
        String errorText = isStore && isMagazine
            ? ""
            : isStore
                ? "定期雑誌を最低一つ以上入力してください"
                : isMagazine
                    ? "店舗名を入力してください"
                    : "店舗名と定期雑誌を入力してください";

        // if (isStore) errorText = "店舗名を入力してください";

        // どちらも空じゃなければ
        if (isStore && isMagazine) {
          // 定期追加処理
          await RegulerManager.addRegular(storeName, addMagezens);
          debugPrint("追加処理");
          // 完了ダイアログ
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    // dialogの角丸
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                  title: const Text('完了'),
                  content: const Text('定期の追加が完了しました'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        } else {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    // dialogの角丸
                    borderRadius: BorderRadius.circular(1.0),
                  ),
                  title: const Text('エラー'),
                  content: Text(errorText),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
      },
      child: Container(
        width: screenSizeWidth * 0.2,
        height: screenSizeHeight * 0.075,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: const Color.fromARGB(255, 221, 221, 221), borderRadius: BorderRadius.circular(1)),
        child: const Text(
          "確定",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('$addTypeを追加しよう！！！！！'),
        ),
        body: Center(
            child: Column(children: [
          // 店舗名の入力
          editStore(),
          // 定期情報の入力
          editData(),
          // 入力した定期の表示
          regularList(),
          // 確定ボタン
          addRegularButton()
        ])));
  }
}
