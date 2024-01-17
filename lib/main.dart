import 'package:bloc_bloc_bloc/pages/counter.dart';
import 'package:bloc_bloc_bloc/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CounterCubit(),
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}

class BlocPlayground extends StatelessWidget {
  const BlocPlayground({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Playground')),
      body: ListView(
        children: [
          const Divider(),
          ListTile(
            title: const Text('Counter Page'),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              context.goNamed(AppRouter.counter.name);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
