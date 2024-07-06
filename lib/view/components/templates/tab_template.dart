import 'package:flutter/material.dart';

class TabTemplate extends StatelessWidget {
  const TabTemplate({super.key, required this.title, required this.children, required this.defaultIndex, required this.tabList});

  final String title;
  final int defaultIndex;
  final List<Tab> tabList;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: defaultIndex, // 初期選択タブ
      length: tabList.length, // タブの数
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          // タブを表示
          bottom: TabBar(
            tabs: [...tabList],
          ),
        ),
        body: TabBarView(
          children: [...children],
        ),
      ),
    );
  }
}
