import 'package:bloc_bloc_bloc/main.dart';
import 'package:bloc_bloc_bloc/pages/counter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRouter {
  counter,
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const BlocPlayground();
      },
      routes: <RouteBase>[
        GoRoute(
          path: AppRouter.counter.name,
          name: AppRouter.counter.name,
          builder: (BuildContext context, GoRouterState state) {
            return const CounterPage();
          },
        ),
      ],
    ),
  ],
);

