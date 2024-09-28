import 'package:flutter/material.dart';

class DeliveryMagazine {
  String magazineCode;
  String magazineName;
  String magazineNumber;
  int quantity;
  int unitPrice;

  DeliveryMagazine({required this.magazineCode, required this.magazineName, required this.magazineNumber, required this.quantity, required this.unitPrice});
}

class Delivery {
  String customerName;
  String customerUUID;

  List<DeliveryMagazine> magazines;

  Delivery({required this.customerName, required this.customerUUID, required this.magazines});

  static List<Delivery> sampleDelibery = [
    Delivery(customerName: 'A店', customerUUID: '1234565432', magazines: [
      DeliveryMagazine(magazineCode: '12345', magazineName: '週刊少年ジャンプ', magazineNumber: '10/01', quantity: 1, unitPrice: 100),
      DeliveryMagazine(magazineCode: '12343', magazineName: '週刊少年マガジン', magazineNumber: '10/01', quantity: 2, unitPrice: 200),
      DeliveryMagazine(magazineCode: '12342', magazineName: '週刊少年サンデー', magazineNumber: '10/01', quantity: 1, unitPrice: 300),
    ]),
    Delivery(customerName: 'B店', customerUUID: '1234565432', magazines: [
      DeliveryMagazine(magazineCode: '12342', magazineName: '週刊少年サンデー', magazineNumber: '10/01', quantity: 1, unitPrice: 300),
    ]),
    Delivery(customerName: 'C店', customerUUID: '1234565432', magazines: [
      DeliveryMagazine(magazineCode: '12345', magazineName: '週刊少年ジャンプ', magazineNumber: '10/01', quantity: 1, unitPrice: 100),
      DeliveryMagazine(magazineCode: '12343', magazineName: '週刊少年マガジン', magazineNumber: '10/01', quantity: 2, unitPrice: 200),
    ]),
  ];

  static List<Delivery> resToDelivery(List res) {
    List<Delivery> deliveries = [];
    for (var data in res) {
      Map<String, dynamic> delivery = data as Map<String, dynamic>;
      List<DeliveryMagazine> magazines_1 = [];
      List<DeliveryMagazine> magazines_2 = [];
      if (delivery['magazines'] == null) {
        continue;
      }

      int i = 0;
      for (var magazine in delivery['magazines']) {
        // 5件以上の場合は別の処理を行う
        if (i > 4) {
          magazines_2.add(DeliveryMagazine(
            magazineCode: magazine['magazineCode'],
            magazineName: magazine['magazineName'],
            magazineNumber: magazine['number'],
            quantity: magazine['quantity'],
            unitPrice: magazine['price'],
          ));
          continue;
        }
        magazines_1.add(DeliveryMagazine(
          magazineCode: magazine['magazineCode'],
          magazineName: magazine['magazineName'],
          magazineNumber: magazine['number'],
          quantity: magazine['quantity'],
          unitPrice: magazine['price'],
        ));

        i++;
      }
      deliveries.add(Delivery(
        customerUUID: delivery['customerUuid'],
        customerName: delivery['customerName'],
        magazines: magazines_1,
      ));
      if (magazines_2.isNotEmpty) {
        deliveries.add(Delivery(
          customerUUID: delivery['customerUuid'],
          customerName: delivery['customerName'],
          magazines: magazines_2,
        ));
      }
    }
    return deliveries;
  }

  static List<DeliveryMagazine> listToMagazine(List<Delivery> deliveries) {
    List<DeliveryMagazine> magazines = [];

    for (var delivery in deliveries) {
      for (var magazine in delivery.magazines) {
        bool isExist = false;
        for (var mag in magazines) {
          // 重複している場合は追加しない
          if (mag.magazineName == magazine.magazineName) {
            isExist = true;
            break;
          }
        }
        if (!isExist) {
          magazines.add(magazine);
        }
      }
    }
    return magazines;
  }

  static List<Delivery> deleteMagazine(List<Delivery> deliveries, String magazineName) {
    for (var delivery in deliveries) {
      // 削除する magazine を一時的に保存するリスト
      List<DeliveryMagazine> magazinesToRemove = [];

      // 削除対象を収集
      for (var magazine in delivery.magazines) {
        if (magazine.magazineName == magazineName) {
          magazinesToRemove.add(magazine);
        }
      }

      // 収集した雑誌を削除
      for (var magazine in magazinesToRemove) {
        delivery.magazines.remove(magazine);
      }
    }

    return deliveries;
  }

  static List<DeliveryMagazine> editToList(List<Map<String, TextEditingController>> editControllers) {
    List<DeliveryMagazine> magazines = [];
    for (var controller in editControllers) {
      magazines.add(DeliveryMagazine(
        magazineCode: controller['magazineCode']!.text,
        magazineName: controller['magazineName']!.text,
        magazineNumber: controller['magazineNumber']!.text,
        quantity: int.parse(controller['quantity']!.text),
        unitPrice: int.parse(controller['price']!.text),
      ));
    }
    return magazines;
  }

  static List<Delivery> editDeliveryList(List<Delivery> deliveries, List<DeliveryMagazine> magazines) {
    //
    for (Delivery delivery in deliveries) {
      for (DeliveryMagazine mag in delivery.magazines) {
        for (DeliveryMagazine editMag in magazines) {
          if (mag.magazineCode == editMag.magazineCode && mag.unitPrice == editMag.unitPrice) {
            mag.magazineName = editMag.magazineName;
            mag.magazineNumber = editMag.magazineNumber;
          }
        }
      }
    }

    return deliveries;
  }
}
