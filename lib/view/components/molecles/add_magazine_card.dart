import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/models/counting_model.dart';

class AddMagazineCard extends StatelessWidget {
  const AddMagazineCard({super.key, required this.index, required this.remove, required this.regular});

  final int index;
  final CountingRegular regular;
  final void Function(int) remove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
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
              Text(regular.magazine.magazineCode),
              const SizedBox(width: 10), // 余白
              Text(regular.magazine.magazineName),
              const SizedBox(width: 10), // 余白
              Text('${regular.regular.quantity.toString()}冊'),
            ],
          ),
        ));
  }
}
