import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloWorldProvider = Provider<String>((_) => "Hello World");

class HelloWorldWidget extends ConsumerWidget {
  const HelloWorldWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(helloWorldProvider);
    return Center(child: Text(value));
  }
}
