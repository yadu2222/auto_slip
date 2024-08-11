// import '../models/regular_model.dart';
// import '../models/magazine_model.dart';

// 雑誌と定期情報のリストを保持するクラス
// 型がごみすぎるだろいいかげんにしろ
import 'package:flutter_auto_flip/models/counting_model.dart';
import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/models/magazine_model.dart';
import 'package:flutter_auto_flip/models/regular_model.dart';

// どっちにせよ型が不安全
class LoadRegular {
  // どちらかを主キーとする
  Customer? customer;
  Magazine? magazine;

  // 定期情報のリスト
  List<CountingCustomer> regulars;

  LoadRegular({
    this.customer,
    this.magazine,
    required this.regulars,
  });

  // 雑誌を主キーとして変換
  static List<LoadRegular> resToMagazineLoadRegular(List res) {
    List<LoadRegular> result = [];
    for (var data in res) {
      // もらったデータをmapに変換
      Map<String, dynamic> load = data as Map<String, dynamic>;
      // mapのリストをループし、格納
      List<CountingCustomer> regulars = [];
      if (load['regulars'] == null) {
        continue;
      }
      for (var regular in load['regulars']) {
        regulars.add(CountingCustomer(
            customer: Customer(
              customerUUID: regular['customer']['customerUUID'] ?? '',
              customerName: regular['customer']['customerName'] ?? '',
              // regularType: regular['customer']['methodType'],
            ),
            regular: Regular(
              regularUUID: regular['regularUUID'] ?? '',
              quantity: regular['quantity'] ?? 0,
            )));
      }
      result.add(LoadRegular(
          magazine: Magazine(
            magazineCode: load['magazine']['magazineCode'],
            magazineName: load['magazine']['magazineName'],
          ),
          regulars: regulars));
    }
    return result;
  }
}
