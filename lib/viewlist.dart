import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sql_learn/controller.dart';

class FormListPage extends HookConsumerWidget {
  const FormListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewList = ref.watch(viewListProvider);
    final viewListState = ref.watch(viewListProvider.notifier);

    useEffect(() {
      viewListState.getDb();
      return null;
    }, []);

    return Scaffold(
        body: ListView.builder(
      itemCount: viewList.length,
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
                    title: Text('ID: [${viewList[index]['id']}]  '
                        'form1: ${viewList[index]['form1']}  '
                        'form2: ${viewList[index]['form2']}'),
                  ),
                ),
              ],
            ));
      },
    ));
  }
}
