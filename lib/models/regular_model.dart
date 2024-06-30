import '../models/magazine_model.dart';

class Regular {
  String regularUUID;
  String customerUUID;
  String customerName;
  int quantity;
  int regularType;
  String regularTypeString;
  Magazine magazine;

  Regular({this.regularUUID = "", this.customerUUID = "", this.customerName = "", required this.quantity, this.regularType = 0, this.regularTypeString = "", required this.magazine});
}
