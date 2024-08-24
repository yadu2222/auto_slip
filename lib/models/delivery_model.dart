class DeliveryMagazine {
  String regularId;
  String magazineName;
  String magazineNumber;
  int quantity;
  int unitPrice;

  DeliveryMagazine({required this.regularId, required this.magazineName, required this.magazineNumber, required this.quantity, required this.unitPrice});
}

class Delivery {
  String storeName;

  List<DeliveryMagazine> magazines;

  Delivery({required this.storeName, required this.magazines});

  static List<Delivery> sampleDelibery = [
    Delivery(storeName: 'A店', magazines: [
      DeliveryMagazine(regularId: '1', magazineName: '週刊少年ジャンプ', magazineNumber: '10/01', quantity: 1, unitPrice: 100),
      DeliveryMagazine(regularId: '2', magazineName: '週刊少年マガジン', magazineNumber: '10/01', quantity: 2, unitPrice: 200),
      DeliveryMagazine(regularId: '3', magazineName: '週刊少年サンデー', magazineNumber: '10/01', quantity: 1, unitPrice: 300),
    ]),
    Delivery(storeName: 'B店', magazines: [
      DeliveryMagazine(regularId: '4', magazineName: '週刊少年ジャンプ', magazineNumber: '10/02', quantity: 1, unitPrice: 100),
      DeliveryMagazine(regularId: '5', magazineName: '週刊少年マガジン', magazineNumber: '10/02', quantity: 2, unitPrice: 200),
      DeliveryMagazine(regularId: '6', magazineName: '週刊少年サンデー', magazineNumber: '10/02', quantity: 3, unitPrice: 300),
    ]),
    Delivery(storeName: 'C店', magazines: [
      DeliveryMagazine(regularId: '7', magazineName: '週刊少年ジャンプ', magazineNumber: '10/03', quantity: 1, unitPrice: 100),
      DeliveryMagazine(regularId: '8', magazineName: '週刊少年マガジン', magazineNumber: '10/03', quantity: 2, unitPrice: 200),
      DeliveryMagazine(regularId: '9', magazineName: '週刊少年サンデー', magazineNumber: '10/03', quantity: 3, unitPrice: 3000),
    ]),
    Delivery(storeName: 'A店', magazines: [
      DeliveryMagazine(regularId: '1', magazineName: '週刊少年ジャンプ', magazineNumber: '10/01', quantity: 1, unitPrice: 100),
      DeliveryMagazine(regularId: '2', magazineName: '週刊少年マガジン', magazineNumber: '10/01', quantity: 2, unitPrice: 200),
      DeliveryMagazine(regularId: '3', magazineName: '週刊少年サンデー', magazineNumber: '10/01', quantity: 1, unitPrice: 300),
    ]),
    Delivery(storeName: 'B店', magazines: [
      DeliveryMagazine(regularId: '4', magazineName: '週刊少年ジャンプ', magazineNumber: '10/02', quantity: 1, unitPrice: 100),
      DeliveryMagazine(regularId: '5', magazineName: '週刊少年マガジン', magazineNumber: '10/02', quantity: 2, unitPrice: 200),
      DeliveryMagazine(regularId: '6', magazineName: '週刊少年サンデー', magazineNumber: '10/02', quantity: 3, unitPrice: 300),
    ]),
    Delivery(storeName: 'C店', magazines: [
      DeliveryMagazine(regularId: '7', magazineName: '週刊少年ジャンプ', magazineNumber: '10/03', quantity: 1, unitPrice: 100),
      DeliveryMagazine(regularId: '8', magazineName: '週刊少年マガジン', magazineNumber: '10/03', quantity: 2, unitPrice: 200),
      DeliveryMagazine(regularId: '9', magazineName: '週刊少年サンデー', magazineNumber: '10/03', quantity: 3, unitPrice: 3000),
    ]),
    Delivery(storeName: 'A店', magazines: [
      DeliveryMagazine(regularId: '1', magazineName: '週刊少年ジャンプ', magazineNumber: '10/01', quantity: 1, unitPrice: 100),
      DeliveryMagazine(regularId: '2', magazineName: '週刊少年マガジン', magazineNumber: '10/01', quantity: 2, unitPrice: 200),
      DeliveryMagazine(regularId: '3', magazineName: '週刊少年サンデー', magazineNumber: '10/01', quantity: 1, unitPrice: 300),
    ]),
    Delivery(storeName: 'B店', magazines: [
      DeliveryMagazine(regularId: '4', magazineName: '週刊少年ジャンプ', magazineNumber: '10/02', quantity: 1, unitPrice: 100),
      DeliveryMagazine(regularId: '5', magazineName: '週刊少年マガジン', magazineNumber: '10/02', quantity: 2, unitPrice: 200),
      DeliveryMagazine(regularId: '6', magazineName: '週刊少年サンデー', magazineNumber: '10/02', quantity: 3, unitPrice: 300),
    ]),
    Delivery(storeName: 'C店', magazines: [
      DeliveryMagazine(regularId: '7', magazineName: '週刊少年ジャンプ', magazineNumber: '10/03', quantity: 1, unitPrice: 100),
      DeliveryMagazine(regularId: '8', magazineName: '週刊少年マガジン', magazineNumber: '10/03', quantity: 2, unitPrice: 200),
      DeliveryMagazine(regularId: '9', magazineName: '週刊少年サンデー', magazineNumber: '10/03', quantity: 3, unitPrice: 3000),
    ]),
  ];
}
