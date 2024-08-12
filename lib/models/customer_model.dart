class Customer {
  String customerUUID;
  String customerName;
  int regularType;

  int tellType; // 0は指定なし？
  String? address;
  String? note;

  Customer({
    this.customerUUID = "",
    this.customerName = "",
    this.regularType = 0,
    this.tellType = 0,
    this.address,
    this.note,
  });

  // エラー時のCustomer
  static Customer errCustomer = Customer(customerUUID: "", customerName: "エラー", regularType: 0, tellType: 0, address: "");

  // 変換
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerUUID: json['customerUUID'],
      customerName: json['customerName'],
      regularType: json['regularType'],
      tellType: json['tellType'],
      address: json['address'],
    );
  }

  static List<Customer> resToCustomer(List res) {
    List<Customer> customerList = [];

    try {
      for (Map loadData in res) {
        customerList.add(Customer(
            customerUUID: loadData['customerUUID'] ?? '',
            customerName: loadData['customerName'] ?? '',
            regularType: loadData['methodType'] ?? 0,
            tellType: loadData['tellType'] ?? 0,
            address: loadData['tellAddress'] ?? '',
            note: loadData['note'] ?? ''));
      }
    } catch (e) {
      print(e);
    }
    return customerList;
  }
}
