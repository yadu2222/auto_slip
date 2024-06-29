import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// 遷移先
import '../view/pages/page_home.dart';
import '../view/pages/page_add.dart';
import '../view/pages/page_regular.dart';
import '../view/pages/page_salary.dart';
import '../view/pages/page_emp.dart';
import '../view/pages/page_magazines_count.dart';
import '../view/pages/page_test.dart';

// // デフォルトで表示しているウィジェット
// import '../view/components/organism/basic_view.dart';

// import '../view/pages/share/page_login.dart';
// import '../view/pages/share/page_user_register.dart';

// // sample
// // import '../constant/sample_data.dart';
// import '../models/user_model.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

// enumで宣言
// enum BranchType {
//   junior,
//   patron,
//   teacher,
// }

// // ひもづけ
// extension BranchTypeExt on BranchType {
//   List<StatefulShellBranch> get branch {
//     switch (this) {
//       case BranchType.teacher:
//         return TeacherBranch.teacherBranchs;

//       case BranchType.junior:
//         return JuniorBranch.juniorBranchs;

//       case BranchType.patron:
//         return PatronBranch.patronBranchs;
//     }
//   }
// }

// Future<List<StatefulShellBranch>> getBranches() async {
//   // final userService = UserService();
//   // final userRole = await userService.getUserRole();

//   // ユーザータイプに合わせたbranchesを返す
//   // dbから取得
//   final int userRole = await User.getUser().then((value) => value.userTypeId);
//   switch (userRole) {
//     case 1:
//       debugPrint('teacher');
//       return BranchType.teacher.branch;
//     case 2:
//       debugPrint('junior');
//       return BranchType.junior.branch;
//     case 3:
//       debugPrint('patron');
//       return BranchType.patron.branch;
//     default:
//       debugPrint('error');
//       return BranchType.junior.branch;
//   }
// }

// ルーターの作成
Future<GoRouter> createRouter() async {
  // jwtkeyが端末内に保存されているかを判別
  // Future<bool> isLoginCheck() async {
  //   User user = await User.getUser();
  //   if (user.jwtKey == "") {
  //     return false;
  //   }
  //   return true;
  // }

  // bool isLogin = await isLoginCheck();

  return GoRouter(
    debugLogDiagnostics: true,
    // initialLocation: isLogin ? '/home' : '/login', // ログイン状態によって初期画面を変更
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
              child: PageRegular(),
            ),
          ),

          // ていきいちらん
          GoRoute(
            path: 'show',
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
              child: PageRegular(),
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
