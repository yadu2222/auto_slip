import 'package:flutter/material.dart';

class AddMagazineButton extends StatelessWidget {
  const AddMagazineButton({super.key, required this.add});

  final void Function() add;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: add,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(), // まるくする
          padding: const EdgeInsets.all(5),
          // Button color
          // backgroundColor: AppColors.iconLight,
          // Splash color
        ),
        child: const Icon(
          Icons.add,
          weight: 20,
          size: 40,
        ));
  }
}
