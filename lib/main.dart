import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sql_learn/controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  late final database;
  await Future.wait(
    [
      Future(() async {
        database = openDatabase(
          join(await getDatabasesPath(), 'formlist_database.db'),
          onCreate: (db, version) {
            return db.execute(
              "CREATE TABLE formlist(id INTEGER PRIMARY KEY, form1 TEXT, form2 TEXT)",
            );
          },
          version: 1,
        );
      })
    ],
  );
  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
      ],
      child: Consumer(
        builder: (context, ref, child) {
          return child!;
        },
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formList = ref.watch(formProvider);
    final formListState = ref.watch(formProvider.notifier);

    final form1TextEditingController = useTextEditingController();
    final form2TextEditingController = useTextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('aa'),
        ),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                controller: form1TextEditingController,
              ),
              TextFormField(
                controller: form2TextEditingController,
              ),
              ElevatedButton(
                child: const Text('aa'),
                onPressed: () {
                  formListState.setForm(form1TextEditingController.text,
                      form2TextEditingController.text);
                },
              ),
              Text(formList.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
