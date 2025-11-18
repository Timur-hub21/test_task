import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_test_task/app/router/app_router.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final GoRouter router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
