import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'controller.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(formProvider);
    final resultState = ref.watch(formProvider.notifier);

    final form1TextEditingController = useTextEditingController();
    final form2TextEditingController = useTextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('sqflite learning'),
        ),
        body: Form(
          child: Column(children: [
            TextFormField(controller: form1TextEditingController),
            TextFormField(controller: form2TextEditingController),
            ElevatedButton(
              child: const Text('計算'),
              onPressed: () {
                resultState.add(
                  form1TextEditingController.text,
                  form2TextEditingController.text,
                );
              },
            ),
            Text(result.toString()),
          ]),
        ),
      ),
    );
  }
}
