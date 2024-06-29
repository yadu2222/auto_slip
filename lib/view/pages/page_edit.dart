import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auto_flip/models/database_helper.dart';
import 'package:flutter_auto_flip/apis/controller/regular_manager.dart';
import '../parts/parts.dart';


import '../atoms/edit_form.dart';

class EditPage extends StatefulWidget {
  // 0で店舗情報、1で雑誌情報、2で定期情報
  int editType;
  String code; // 編集するデータの識別子
  EditPage(this.editType, this.code);

  @override
  _EditPageState createState() => _EditPageState();
}

///  編集ページ
///  ・店舗情報
///  ・雑誌情報
///  ・定期情報

class _EditPageState extends State<EditPage> {
  TextEditingController userNameController = TextEditingController();     // 編集者の名前
  TextEditingController storeNameController = TextEditingController();    // 店舗名
  TextEditingController magazineNameController = TextEditingController(); // 雑誌名
  TextEditingController magazineCodeController = TextEditingController(); // 雑誌コード
  TextEditingController regularController = TextEditingController();      // 定期情報

  @override
  initState() {
    super.initState();
    debugPrint("もらってきたよ:${widget.editType.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;

    // 名前を入力させる
    // 履歴を残すため
    // TODO:従業員名簿にあるかの確認を行うか？あとできめる
    // 一致しなければ弾くみたいな処理になる？二度手間では？
    // 多分したほうがいい
    Widget editName() {
      return Container(
        padding: EdgeInsets.all(10),
        width: screenSizeWidth * 0.6,
        child: TextField(
          controller: userNameController,
          decoration: const InputDecoration(
            hintText: 'あなたの名前を入力してください',
          ),
        ),
      );
    }

    // 編集確定ボタン
    // TODO:どうやってもらおう
    Widget editButton(Map<String, dynamic> addData, int addType) {
      String tableName = "";
      switch (addType) {
        case 0:
          tableName = "stores";
          break;
        case 1:
          tableName = "magazines";
          break;
        case 2:
          tableName = "regulars";
          break;
      }
      // 編集履歴の保存
      Map<String, dynamic> addHistory = {
        "emp_id": "", // 編集者ID
        "edit_time": "", // 編集時間
        "edit_type": "", // 編集種別　更新削除追加など　追加も載せるのか、、？というきもちありけりではある　のせたほうがいいかも
        "edit_data": "", // 変更点
      };

      return ElevatedButton(
        onPressed: () {
          // // 編集内容を確定
          // DatabaseHelper.insert(tableName, addData);
          // // 編集履歴の保存
          // DatabaseHelper.insert("editHistory", addHistory);
        },
        child: const Text('確定'),
      );
    }

    // 定期先の情報編集用フォーム
    Widget storeEditForm() {
      return Column(
        children: [
          // ここは下段では？そうです

          TextFormField(
            controller: storeNameController,
            decoration: const InputDecoration(
              hintText: '店舗名を入力してください',
            ),
          ),
        ],
      );
    }

    // 表示するリスト
    Widget disListView(TextEditingController controller, int searchType, List updData) {
      // 表示したいこと
      List columns = [];
      debugPrint("よみこんでる？？？？？？？？？");

      // // TODO:1つ目以外整備してない
      switch (searchType) {
        case 0:
          columns = ["store_id", "store_name", "regular_type", "address", "tell_type", "note"];
          break;
        case 1:
          columns = ["magazine_code", "magazine_name"];
          break;
        case 2:
          columns = ["regular_id", "store_id", "magazine_code", "quantity", "regular_type"];
          break;
      }

      // TODO:変更前と、同じフォームを並べて、比較して入力できるようにする
      return
          // とってきた情報を表示する
          FutureBuilder(
              future: RegulerManager.getRegularList(controller.text.toString(), searchType),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  debugPrint("さーち${searchType.toString()}");
                  debugPrint("およよよよよよよ ${snapshot.data.toString()}");
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // TODO:column名の反映をどうしよう
                      // 場合分けでいちいち書くのか、、？でもそれが一番わかりやすいかもしれない
                      // for文で回せないわ　どうしようかしら

                      Container(
                        width: screenSizeWidth * 0.4,
                        height: screenSizeHeight * 0.1,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  debugPrint("??? error");
                  return const Text("エラーが発生しました");
                } else {
                  debugPrint("???　karadayo");
                  return const Text("検索結果がありません");
                }
              });
    }

    // 検索欄を設ける？

    // 動作
    // 画面の再読み込みくらい？
    // 使わないけど引数として必要なのでこのままにしておく
    void hoge(int n) {
      debugPrint(userNameController.text);
      if (userNameController.text != "") {
        // 画面の再読み込み
        setState() {
          debugPrint("うごいてるよ");
        }
        // 名前が入力されていない場合はエラーを表示
      } else {
        debugPrint("空だけどだいじょぶそ？");
      }
    }

    Widget mainDisp(int editType, IconData icon, String hintText, TextEditingController controller) {
      return Center(
          child: Center(
        child: Column(
          children: [
            // あなたは誰ですか？
            // 編集者の名前を残す
            editName(),
            // 今回addTypeは使わないので、適当な値を入れておく
            Parts.searchBar(icon, hintText, controller, 0, hoge),
            // listviewをつかうときは外枠定義しとかないと落ちるよという忘れていた大切な知見
            SizedBox(
              width: screenSizeWidth * 0.6,
              height: screenSizeHeight * 0.4,
              child: disListView(controller, editType, []),
            )
          ],
        ),
      ));
    }

    return DefaultTabController(
      initialIndex: widget.editType, // 初期選択タブ
      length: 3, // タブの数
      child: Scaffold(
        appBar: AppBar(
          title: const Text('編集'),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: '連絡先',
              ),
              Tab(
                text: '雑誌',
              ),
              Tab(
                text: '定期',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 定期先の名称
            mainDisp(0, Icons.storefront_outlined, "定期先の名称を入力してください", storeNameController),
            mainDisp(1, Icons.book_outlined, "雑誌名を入力してください", magazineNameController),
            // TODO: 定期情報の編集をするページ　ヒントテキストを考える
            mainDisp(2, Icons.sell, "なんてかこうかな", regularController),
          ],
        ),
      ),
    );
  }
}
