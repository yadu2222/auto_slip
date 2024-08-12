import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/view/components/organisms/main_menu.dart';

class BasicTemplate extends StatelessWidget {
  const BasicTemplate({super.key, required this.title, required this.children, this.floatingActionButton});

  final String title;
  final List<Widget> children;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      //
      // ),
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const MainMenu(),
                Expanded(
                  child: Column(
                    children: [
                      AppBar(
                        title: Text(title),
                        actions: [floatingActionButton ?? const SizedBox.shrink()],
                      ),
                      ...children,
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
