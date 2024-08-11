class Customer {
  String customerUUID;
  String customerName;
  int regularType;

  int tellType; // 0は指定なし？
  String? address;

  Customer({this.customerUUID = "", this.customerName = "", this.regularType = 0, this.tellType = 0, this.address});

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

  static List<Customer> resToCustomer(Map res) {
    List<Customer> customerList = [];
    if (res['customerList'] != null) {
      res['customerList'].forEach((v) {
        customerList.add(Customer.fromJson(v));
      });
    }
    return customerList;
  }
}
