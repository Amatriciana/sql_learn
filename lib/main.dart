import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sql_learn/controller.dart';
import 'form.dart';
import 'formlist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final databaseProvider =
    Provider<Future<Database>>((ref) => throw UnimplementedError());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late final Future<Database> database;
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
      overrides: [databaseProvider.overrideWithValue(database)],
      child: Consumer(
        builder: (context, ref, child) {
          return child!;
        },
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNav = ref.watch(bottomNavProvider);
    final bottomNavState = ref.watch(bottomNavProvider.notifier);

    final List _pageList = [
      const FormPage(),
      const FormListPage(),
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('aa')),
        body: _pageList[bottomNav.index],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNav.index,
          onTap: (int selectPage) {
            bottomNavState.state = BottomNav.values[selectPage];
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'フォーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'リスト',
            ),
          ],
        ),
      ),
    );
  }
}
