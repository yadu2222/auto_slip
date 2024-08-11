import 'package:flutter/material.dart';
import '../../../models/regular_model.dart';

class AddMagazineCard extends StatelessWidget {
  const AddMagazineCard({super.key, this.width = 0.6, this.height = 0.1, required this.index, required this.remove, required this.regular});

  final double width;
  final double height;
  final int index;
  final Regular regular;
  final void Function(int) remove;

  @override
  Widget build(BuildContext context) {
    return Card(
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

          // TODO
          // Container(alignment: Alignment.center, child: Text(regular.magazine.magazineCode)),
          // const SizedBox(width: 10), // 余白
          // Container(alignment: Alignment.center, child: Text(regular.magazine.magazineName)),
          const SizedBox(width: 10), // 余白
          Container(alignment: Alignment.center, child: Text(regular.quantity.toString()))
        ],
      ),
    );
  }
}
