import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sql_learn/database.dart';

class FormListPage extends HookConsumerWidget {
  const FormListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formListDb = ref.watch(formListDbProvider);
    final formListDbState = ref.watch(formListDbProvider.notifier);

    useEffect(() {
      Future(() async {
        formListDbState.getTest();
      });
      return null;
    }, []);

    return Scaffold(
        body: ListView.builder(
      itemCount: formListDb.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
            key: UniqueKey(),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: ListTile(
                    title: Text('${formListDb[index]}'),
                  ),
                ),
              ],
            ));
      },
    ));
  }
}
