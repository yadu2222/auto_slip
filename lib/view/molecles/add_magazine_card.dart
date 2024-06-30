import 'package:flutter/material.dart';
import '../../models/regular_model.dart';

class AddMagazineCard extends StatelessWidget {
  const AddMagazineCard({super.key, this.width = 0.6, this.height = 0.1, required this.index, required this.remove, required this.regular});

  final double width;
  final double height;
  final int index;
  final Regular regular;
  final void Function(int) remove;

  @override
  Widget build(BuildContext context) {
    //画面サイズ
    var screenSizeWidth = MediaQuery.of(context).size.width;
    var screenSizeHeight = MediaQuery.of(context).size.height;
    return Card(
        // color: Constant.glay.withAlpha(0),
        //           elevation: 0,
        elevation: 0,
        child: SizedBox(
          width: screenSizeWidth * width,
          height: screenSizeHeight * height,
          child: Row(
            children: [
              // 削除ボタン
              IconButton(
                  onPressed: () {
                    // setState(() {
                    //   addMagezens.removeAt(index);
                    // });
                    remove(index);
                  },
                  icon: const Icon(
                    Icons.horizontal_rule,
                    color: Colors.black,
                    size: 20,
                  )),
              // 情報の表示
              Container(width: screenSizeWidth * 0.225, height: screenSizeHeight * 0.1, alignment: Alignment.center, child: Text(regular.magazine.magazineCode)),
              Container(width: screenSizeWidth * 0.225, height: screenSizeHeight * 0.1, alignment: Alignment.center, child: Text(regular.magazine.magazineName)),
              Container(width: screenSizeWidth * 0.15, height: screenSizeHeight * 0.1, alignment: Alignment.center, child: Text(regular.quantity.toString()))
            ],
          ),
        ));
  }
}
