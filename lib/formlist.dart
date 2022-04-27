import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormListPage extends HookConsumerWidget {
  const FormListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = [
      {
        'id': '1',
        'form1': '2',
        'form2': '3',
      },
      {
        'id': '4',
        'form1': '5',
        'form2': '6',
      }
    ];

    return Scaffold(
        body: ListView.builder(
      itemCount: list.length,
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
                    title: Text('ID: [${list[index]['id']}]  '
                        'form1: [${list[index]['form1']}]  '
                        'form2: [${list[index]['form2']}]'),
                  ),
                ),
              ],
            ));
      },
    ));
  }
}
