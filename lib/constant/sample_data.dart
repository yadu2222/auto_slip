import '../models/load_regular_model.dart';
import '../models/magazine_model.dart';
import '../models/regular_model.dart';
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
    regularTypeString: "type1",
  );

  static Regular regular1 = Regular(
    magazine: magazine1,
    quantity: 1,
    customer: customer1,
    regularUUID: "uuid1",
  );

  static Regular regular2 = Regular(
    magazine: magazine2,
    quantity: 2,
    customer: customer1,
    regularUUID: "uuid2",
  );

  // LoadRegular インスタンスの作成

  static final LoadRegular loadRegular = LoadRegular(
    loadRegularList: [
      {
        'magazine': magazine1,
        'regulars': [regular1],
      },
      {
        'magazine': magazine2,
        'regulars': [regular1, regular2],
      },
    ],
  );

   static final LoadRegular loadRegular2 = LoadRegular(
    loadRegularList: [
      {
        'magazines': [magazine1],
        'regular': regular1,
      },
       {
        'magazines': [magazine1],
        'regular': regular1,
      },
    ],
  );
}
