import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 遷移先
import '../view/pages/page_home.dart';
import '../view/pages/page_add.dart';
import '../view/pages/page_regular.dart';
// import '../view/pages/page_salary.dart';
import '../view/pages/page_magazines_count.dart';
import '../view/pages/page_test.dart';
import '../view/pages/page_edit.dart';


final rootNavigatorKey = GlobalKey<NavigatorState>();
// ルーターの作成
Future<GoRouter> createRouter() async {

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/home',
    routes: [
      // ホーム
      GoRoute(
        path: '/home',
        routes: [
          // かずとり
          GoRoute(
            path: 'add',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: PageAdd(),
            ),
          ),
          // かずとり
          GoRoute(
            path: 'count',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const PageMagazineCount(),
            ),
          ),

          // ていきいちらん
          GoRoute(
            path: 'show',
            routes: [
              // 編集
               GoRoute(
                path: 'edit',
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: PageEdit(),
                ),
              ),
              ],
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: PageRegular(),
            ),
          ),

          // てすと
          GoRoute(
            path: 'test',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: Test(),
            ),
          ),
        ],
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: PageHome(),
        ),
      ),

      // ボトムバーが必要な画面のルーティング
      // いらなければ StatefulShellRoute と同じ階層に GoRoute で書く
      // StatefulShellRoute.indexedStack(
      //     // parentNavigatorKey: rootNavigatorKey,    // これがあると初期画面で/homeにたどり着けない 原因究明中
      //     // ここで常時表示させたいクラスをビルドしている
      //     builder: (context, state, navigationShell) {
      //       return BasicScreenView(navigationShell: navigationShell);
      //     },
      //     branches: [...await getBranches()])
    ],
  );
}
