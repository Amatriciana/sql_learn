import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FormListPage extends HookConsumerWidget {
  const FormListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = [
      ['1', '2', '3']
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
                    title: Text('${list[index][0]}'
                        '${list[index][1]}'
                        '${list[index][2]}'),
                  ),
                ),
              ],
            ));
      },
    ));
  }
}
