import 'package:flutter/material.dart';
import 'package:flutter_auto_flip/view/pages/page_customer.dart';
import 'package:flutter_auto_flip/view/pages/page_magazine.dart';
import 'package:go_router/go_router.dart';

// 遷移先
import '../view/pages/page_counting.dart';
import '../view/pages/page_add_regular.dart';
import '../view/pages/page_regular.dart';
import '../view/pages/page_add_customer.dart';
import '../view/pages/page_add_magazine.dart';
// import '../view/pages/page_salary.dart';
import '../view/page_test.dart';

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
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: PageCounting(),
        ),
        // てすと
      ),
      
      // 編集
      GoRoute(
          path: '/regular',
          routes: [
            // 登録
            GoRoute(
              path: 'add',
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: PageAdd(),
              ),
            ),
          ],
          pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: PageRegularMagazine(),
        ),
      ),
      // 雑誌
      GoRoute(
        path: '/magazine',
        routes: [
           // 登録
          GoRoute(
            path: 'add',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: PageAddMagazine(),
            ),
          ),

        ],
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: PageMagazine(),
        ),
      ),
      // 顧客
      GoRoute(
        path: '/customer',
         routes: [
          // 登録
          GoRoute(
            path: 'add',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: PageAddCustomer(),
            ),
          ),
        ],
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: PageCustomer(),
        ),
      ),
      GoRoute(
        path: '/test',
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: Test(),
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
