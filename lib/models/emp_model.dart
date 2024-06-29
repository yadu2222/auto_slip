
class Employee{


  String userUUID;
  String userName;
  int userTypeId;       // 1: 店長, 2: 店員
  String mailAddress;
  String password;
  String jtiUUID;
  String jwtKey;

  Employee({this.userUUID = 'userUUID', required this.userName, required this.userTypeId, required this.mailAddress, required this.password, required this.jtiUUID, required this.jwtKey});

  static Employee errorEmp() {
    return Employee(userName: '', userTypeId: 0, mailAddress: '', password: '', jtiUUID: '', jwtKey: '');
  }

  





}