import 'package:flutter/material.dart';

class BasicTemplate extends StatelessWidget {
  const BasicTemplate({super.key,required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: child,
      ),
      
    );
  }
}
