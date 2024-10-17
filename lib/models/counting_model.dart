import 'package:flutter_auto_flip/models/customer_model.dart';
import 'package:flutter_auto_flip/models/magazine_model.dart';
import 'package:flutter_auto_flip/models/regular_model.dart';

class CountingCustomer {
  final Customer customer;
  final Regular regular;
  const CountingCustomer({required this.customer, required this.regular});
}

class CountingRegular {
  final Regular regular;
  final Magazine magazine;
  const CountingRegular({required this.regular, required this.magazine});
}

class RegisterRegular {
  final Customer? customer;
  List<CountingRegular> regulars;
  RegisterRegular({required this.customer, required this.regulars});
}

class CountType {
  final int store;
  final int delivery;
  final int library;
  final int hauler;
  final int slip;
  const CountType({required this.store, required this.delivery, required this.library, required this.hauler, required this.slip});
}

class Counting {
  final String countingUUID;
  final Magazine magazine;
  final bool countingFlag;
  final CountType count;
  final List<CountingCustomer> countingCustomers;
  const Counting({required this.countingUUID, required this.magazine, required this.countingFlag, required this.count, required this.countingCustomers});

  // レスポンスからの変換
  static List<Counting> resToCounting(List<dynamic> resData) {
    List<Counting> countings = [];
    for (Map<String, dynamic> data in resData) {
      List<CountingCustomer> countingCustomers = [];

      for (Map<String, dynamic> customer in data['regularAgencys']) {
        countingCustomers.add(CountingCustomer(
          regular: Regular(
            regularUUID: customer['regularUUID'] ?? '',
            quantity: customer['quantity'] ?? 0,
          ),
          customer: Customer(
            customerUUID: customer['customerUUID'] ?? '',
            customerName: customer['customerName'] ?? '',
            ruby: customer['ruby'] ?? '',
            regularType: customer['methodType'] ?? 0,
            tellType: customer['tellType'] ?? 0,
            address: customer['address'] ?? '',
          ),
        ));
      }

      // ふりがな順に並べ替え
      countingCustomers.sort((a, b) => a.customer.ruby!.compareTo(b.customer.ruby!));

      countings.add(Counting(
        countingUUID: data['agency']['countingUUID'] ?? '',
        countingFlag: data['countFlag'] ?? false,
        count: CountType(
          store: data['storeCount'] ?? 0,
          delivery: data['deliveryCount'] ?? 0,
          library: data['livraryCount'] ?? 0,
          hauler: data['haulerCount'] ?? 0,
          slip: data['storeSlipCount'] ?? 0,
        ),
        magazine: Magazine(
          magazineUUID: data['agency']['magazineUUID'] ?? '',
          magazineName: data['agency']['magazineName'] ?? '',
          magazineCode: data['agency']['magazineCode'] ?? '',
          quantityStock: data['agency']['quantity'] ?? 0,
          number: data['agency']['number'] ?? '',
          note:data['note'] ?? ''
        ),
        countingCustomers: countingCustomers,
      ));
    }
    return countings;
  }
}
