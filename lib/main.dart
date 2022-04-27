import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:sql_learn/controller.dart';
import 'form.dart';
import 'formlist.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait(
    [],
  );
  runApp(
    ProviderScope(
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
