class Customer {
  String customerUUID;
  String customerName;
  int regularType;
  String regularTypeString;
  int tellType; // 0は指定なし？
  String tellTypeString;
  String? address;

  Customer({this.customerUUID = "", this.customerName = "", this.regularType = 0, this.regularTypeString = "", this.tellType = 0, this.tellTypeString = "", this.address});

  // エラー時のCustomer
  static Customer errCustomer = Customer(customerUUID: "", customerName: "エラー", regularType: 0, regularTypeString: "", tellType: 0, tellTypeString: "", address: "");

  // 変換
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      customerUUID: json['customerUUID'],
      customerName: json['customerName'],
      regularType: json['regularType'],
      regularTypeString: json['regularTypeString'],
      tellType: json['tellType'],
      tellTypeString: json['tellTypeString'],
      address: json['address'],
    );
  }

  static List<Customer> resToCustomer(Map res){
    List<Customer> customerList = [];
    if (res['customerList'] != null) {
      res['customerList'].forEach((v) {
        customerList.add(Customer.fromJson(v));
      });
    }
    return customerList;
  }

}
