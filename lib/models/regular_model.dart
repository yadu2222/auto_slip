import '../models/magazine_model.dart';
import '../models/customer_model.dart';

class Regular {
  String regularUUID;
  int quantity;
  Customer customer;
  Magazine magazine;

  Regular({this.regularUUID = "", this.quantity = 0, required this.customer, required this.magazine});
}
