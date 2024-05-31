import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_health_tracker/application/auth/auth_state.dart';
import 'package:personal_health_tracker/presention/screens/change_password_screen.dart';
import 'package:personal_health_tracker/presention/screens/delete_account_page.dart';
import 'package:personal_health_tracker/presention/screens/home_page.dart';
import 'package:personal_health_tracker/presention/screens/login_page.dart';
import 'package:personal_health_tracker/presention/screens/signup_page.dart';
import 'package:personal_health_tracker/presention/screens/admin_page.dart'; 

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateNotifierProvider);
  final initialLocation = authState.token != null
      ? (authState.role == 'admin' ? '/admin' : '/home')
      : '/login';
      // print(authState.role);
      // print(authState.token);

  return GoRouter(
    initialLocation: initialLocation,
    refreshListenable:
        GoRouterRefreshStream(ref.watch(authStateNotifierProvider.notifier).stream),
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) =>
            authState.token != null ? (authState.role == 'admin' ? '/admin' : '/home') : '/login',
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => AdminPage(), 
      ),
      GoRoute(
        path: '/change_password',
        builder: (context, state) => ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/delete_account',
        builder: (context, state) => DeleteAccountScreen(),
      ),
    ],
  );
});

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Personal Health Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    stream.listen((event) {
      notifyListeners();
    });
  }
}
