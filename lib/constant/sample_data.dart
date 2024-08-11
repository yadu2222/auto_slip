import '../models/magazine_model.dart';
import '../models/regular_model.dart';
import '../models/customer_model.dart';
import '../models/load_regular_model.dart';

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

  static List<LoadRegular> loadRegulars = [
    LoadRegular(
      magazine: magazine1,
      regulars: [
        {
          "regular": Regular(
            regularUUID: 'fajdsalkfjsd',
            quantity: 1,
          ),
          "customer": customer1,
        },
        {
          "regular": Regular(
            regularUUID: 'fajdsalkfjsd',
            quantity: 1,
          ),
          "customer": customer1,
        },
        {
          "regular": Regular(
            regularUUID: 'fajdsalkfjsd',
            quantity: 1,
          ),
          "customer": customer1,
        },
      ],
    ),
    LoadRegular(
      magazine: magazine1,
      regulars: [
        {
          "regular": Regular(
            regularUUID: 'fajdsalkfjsd',
            quantity: 1,
          ),
          "customer": customer1,
        },
        {
          "regular": Regular(
            regularUUID: 'fajdsalkfjsd',
            quantity: 1,
          ),
          "customer": customer1,
        },
        {
          "regular": Regular(
            regularUUID: 'fajdsalkfjsd',
            quantity: 1,
          ),
          "customer": customer1,
        },
      ],
    ),
  ];

  // LoadRegular インスタンスの作成
}
