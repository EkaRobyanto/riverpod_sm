import 'package:go_router/go_router.dart';
import 'package:riverpod_sm/main.dart';

class CustomRouter {
  static final GoRouter route = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'counter',
            builder: (context, state) => const CounterPage(),
          ),
        ],
      ),
    ],
  );
}
