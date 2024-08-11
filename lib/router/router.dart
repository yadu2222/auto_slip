import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/view/pages/page_magazine.dart';
import 'package:go_router/go_router.dart';

// 遷移先
import '../view/pages/page_home.dart';
import '../view/pages/page_add.dart';
import '../view/page_regular.dart';
// import '../view/pages/page_salary.dart';
import '../view/page_test.dart';
import '../view/pages/page_edit.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
// ルーターの作成
Future<GoRouter> createRouter() async {
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      // ホーム
      GoRoute(
        path: '/',
        routes: [
          // 登録
          GoRoute(
            path: 'add',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: PageAdd(),
            ),
          ),
          // // かずとり
          // GoRoute(
          //   path: 'count',
          //   pageBuilder: (context, state) => NoTransitionPage(
          //     key: state.pageKey,
          //     child: const PageMagazineCount(),
          //   ),
          // ),

          // // ていきいちらん
          // GoRoute(
          //   path: 'show',
          //   pageBuilder: (context, state) => NoTransitionPage(
          //     key: state.pageKey,
          //     child: PageRegular(),
          //   ),
          // ),
          // 編集
          GoRoute(
              path: 'edit',
              pageBuilder: (context, state) {
                if (state.extra == null) {
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: PageEdit(startIndex: 0, serachWord: ''),
                  );
                } else {
                  final Map<String, dynamic> extraData = state.extra as Map<String, dynamic>;
                  return NoTransitionPage(
                    key: state.pageKey,
                    child: PageEdit(
                      startIndex: extraData['startIndex'] as int,
                      serachWord: extraData['serachWord'] as String,
                    ),
                  );
                }
              }),
          // 雑誌
          GoRoute(
            path: 'magazine',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: PageMagazine(),
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
