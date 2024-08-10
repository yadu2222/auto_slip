import 'package:flutter/material.dart';

class BasicTemplate extends StatelessWidget {
  const BasicTemplate({super.key,required this.title, required this.child,this.floatingActionButton});

  final String title;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [floatingActionButton ?? const SizedBox.shrink()],
      ),
      body: Center(
        child: child,
      ),
      
    );
  }
}
