class Customer {
  String customerUUID;
  String customerName;
  int regularType;
  String regularTypeString;
  int tellType; // 0は指定なし？
  String tellTypeString;
  String? address;

  Customer({this.customerUUID = "", this.customerName = "", this.regularType = 0, this.regularTypeString = "", this.tellType = 0, this.tellTypeString = "", this.address});
}
