import 'package:flutter/material.dart';
import 'package:flutter_app/counter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class CounterPage extends ConsumerWidget{
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Example'),
      ),
      body: Center(
        child: Text('Counter : $counter', style: TextStyle(fontSize: 24),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        ref.read(counterStateProvider.notifier).state++;
      }, child: Icon(Icons.add)),
    );
  }

}