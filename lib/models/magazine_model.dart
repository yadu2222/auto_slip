class Magazine {
  String? magazineUUID;
  String magazineName;
  String magazineCode;
  int quantityStock;
  String? number;
  Magazine({this.magazineUUID, required this.magazineName, required this.magazineCode, this.quantityStock = 0,this.number});

  static List<Magazine> resToMagazines(List res) {
    List<Magazine> magazines = [];
    for (var item in res) {
      magazines.add(Magazine(
        magazineName: item['magazineName'],
        magazineCode: item['magazineCode'],
      ));
    }
    return magazines;
  }

  static Magazine? resToMagazine(Map res) {
    if (res['magazineName'] == '') return null;
    try {
      return Magazine(
        magazineName: res['magazineName'],
        magazineCode: res['magazineCode'],
      );
    } catch (e) {
      return null;
    }
  }
}
