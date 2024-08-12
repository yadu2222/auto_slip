import '../models/magazine_model.dart';

import '../models/customer_model.dart';


class SampleData {
  static Magazine magazine1 = Magazine(
    magazineCode: "code1",
    magazineName: "name1",
    quantityStock: 1,
  );

  static Magazine magazine2 = Magazine(
    magazineCode: "code2",
    magazineName: "name2",
    quantityStock: 2,
  );

  static Customer customer1 = Customer(
    customerUUID: "uuid1",
    customerName: "customer1",
    regularType: 1,
  );


  // LoadRegular インスタンスの作成
}
