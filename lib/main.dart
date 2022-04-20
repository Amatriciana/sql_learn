import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
              child: Text('計算'),
              onPressed: () {},
            ),
          ]),
        ),
      ),
    );
  }
}
