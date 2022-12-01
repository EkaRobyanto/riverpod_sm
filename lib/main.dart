// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_sm/router.dart';

import 'counter_provider.dart';

//Classic Counter App

// ignore: prefer_const_constructors
void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Counter App',
      routerConfig: CustomRouter.route,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
          surface: const Color(0xff003909),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Counter App'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              return context.go('/counter');
            },
            child: const Text("Start Counting"),
          ),
        ));
  }
}

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    Color color = Colors.white;

    ref.listen(counterProvider, (previous, next) {
      if (next >= 10) {
        color = Colors.amber;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Counting'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            return context.go('/');
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            counter.toString(),
            style: TextStyle(
              fontSize: counter.toDouble() * 3,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  ref.read(counterProvider.notifier).state++;
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  counter == 0 ? null : ref.invalidate(counterProvider);
                  //or
                  //counter == 0 ? null : ref.refresh(counterProvider);
                  //invalidate is more efficient than refresh because it doesn't rebuild the widget tree
                },
                icon: Icon(Icons.refresh_outlined),
              ),
              IconButton(
                onPressed: () {
                  counter == 0
                      ? null
                      : ref.read(counterProvider.notifier).state--;
                },
                icon: Icon(Icons.minimize_outlined),
              )
            ],
          )
        ],
      ),
    );
  }
}
