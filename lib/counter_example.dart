import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CounterExampleScreen extends StatefulWidget {
  const CounterExampleScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const CounterExampleScreen());
  }

  @override
  State<CounterExampleScreen> createState() => _CounterExampleScreenState();
}

class _CounterExampleScreenState extends State<CounterExampleScreen> {
  final _counter = signal(0);

  late final _doubleCounter = computed(() => _counter.value * 2);

  @override
  void initState() {
    super.initState();

    _counter.onDispose(() {
      log('_counter disposed.', name: '${_counter.runtimeType}');
    });

    _doubleCounter.onDispose(() {
      log('_doubleCounter disposed.', name: '${_doubleCounter.runtimeType}');
    });
  }

  @override
  void dispose() {
    _counter.dispose();
    _doubleCounter.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void addCounter() {
      _counter.value++;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Counter example'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_counter.watch(context)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              '${_doubleCounter.watch(context)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addCounter,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
