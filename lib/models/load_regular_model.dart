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
  // 定期情報のリスト
  // どちらかを主キーとする
  Customer? customer;
  List<CountingRegular>? regular;

  Magazine? magazine;
  List<CountingCustomer>? regulars;

  LoadRegular({
    this.customer,
    this.magazine,
    this.regular,
    this.regulars,
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
              ruby: regular['customer']['ruby'] ?? '',
              customerName: regular['customer']['customerName'] ?? '',
              regularType: regular['customer']['methodType'],
            ),
            regular: Regular(
              regularUUID: regular['regularUUID'] ?? '',
              quantity: regular['quantity'] ?? 0,
            )));
      }

      // customerName順に並べ替え
      regulars.sort((a, b) => a.customer.ruby!.compareTo(b.customer.ruby!));

      result.add(LoadRegular(
          magazine: Magazine(
            magazineCode: load['magazine']['magazineCode'],
            magazineName: load['magazine']['magazineName'],
            note: load['magazine']['note'],
          ),
          regulars: regulars));
    }
    return result;
  }

  // 顧客を主キーとして変換
  static List<LoadRegular> resToCustomerLoadRegular(List res) {
    List<LoadRegular> result = [];
    for (var data in res) {
      // もらったデータをmapに変換
      Map<String, dynamic> load = data as Map<String, dynamic>;
      // mapのリストをループし、格納
      List<CountingRegular> regulars = [];
      if (load['regulars'] == null) {
        continue;
      }
      for (var regular in load['regulars']) {
        regulars.add(CountingRegular(
            magazine: Magazine(
              magazineCode: regular['magazine']['magazineCode'] ?? '',
              magazineName: regular['magazine']['magazineName'] ?? '',
              note: regular['magazine']['note'] ?? '',
            ),
            regular: Regular(
              regularUUID: regular['regularUUID'] ?? '',
              quantity: regular['quantity'] ?? 0,
            )));
      }
      result.add(LoadRegular(
          customer: Customer(
            customerUUID: load['customer']['customerUUID'] ?? '',
            customerName: load['customer']['customerName'] ?? '',
            regularType: load['customer']['methodType'] ?? '',
            tellType: load['customer']['tellType'] ?? 0,
            address: load['customer']['tellAddress'] ?? '',
            note: load['customer']['note'],
          ),
          regular: regulars));
    }
    return result;
  }
}
