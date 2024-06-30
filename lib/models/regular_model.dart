import '../models/magazine_model.dart';

class Regular {
  String? regularUUID;
  String? customerUUID;
  int quantity;
  int? regularType;
  Magazine magazine;


  Regular({this.regularUUID, this.customerUUID, required this.quantity, this.regularType, required this.magazine});

}
