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
      List<DeliveryMagazine> magazines = [];
      if (delivery['magazines'] == null) {
        continue;
      }
      for (var magazine in delivery['magazines']) {
        magazines.add(DeliveryMagazine(
          magazineCode: magazine['magazineCode'],
          magazineName: magazine['magazineName'],
          magazineNumber: magazine['number'],
          quantity: magazine['quantity'],
          unitPrice: magazine['price'],
        ));
      }
      deliveries.add(Delivery(
        customerUUID: delivery['customerUuid'],
        customerName: delivery['customerName'],
        magazines: magazines,
      ));
    }
    return deliveries;
  }
}
