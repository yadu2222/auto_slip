import '../models/load_regular_model.dart';
import '../models/magazine_model.dart';
import '../models/regular_model.dart';

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

  static Regular regular1 = Regular(
    magazine: magazine1,
    quantity: 1,
    regularType: 1,
    regularTypeString: "type1",
    customerName: "customer1",
    customerUUID: "uuid1",
    regularUUID: "uuid1",
  );

  static Regular regular2 = Regular(
    magazine: magazine2,
    quantity: 2,
    regularType: 2,
    regularTypeString: "type2",
    customerName: "customer2",
    customerUUID: "uuid2",
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
}
