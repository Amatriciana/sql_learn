import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:sql_learn/controller.dart';
import 'package:sql_learn/database.dart';

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

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formList = ref.watch(formProvider);
    final formListState = ref.watch(formProvider.notifier);
    final formdatabaseState = ref.watch(formListDbProvider.notifier);

    final form1TextEditingController = useTextEditingController();
    final form2TextEditingController = useTextEditingController();

    useEffect(() {
      Future(() async {
        formdatabaseState.formListdatabase();
      });
      return null;
    }, []);

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
