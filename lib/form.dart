import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'controller.dart';
import 'database.dart';

class FormPage extends HookConsumerWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formList = ref.watch(formProvider);
    final formListState = ref.watch(formProvider.notifier);
    final formdatabase = ref.watch(formListDbProvider);
    final formdatabaseState = ref.watch(formListDbProvider.notifier);

    final form1TextEditingController = useTextEditingController();
    final form2TextEditingController = useTextEditingController();

    useEffect(() {
      Future(() async {
        formdatabaseState.formListdatabase();
      });
      return null;
    }, []);

    return Scaffold(
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
                formdatabaseState.test1(form1TextEditingController.text,
                    form2TextEditingController.text);
              },
            ),
            Text(formList.toString()),
            Text(formdatabase['form1'].toString()),
          ],
        ),
      ),
    );
  }
}
