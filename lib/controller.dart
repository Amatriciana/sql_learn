import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'database.dart';

final formProvider = StateNotifierProvider.autoDispose<FormController, List>(
    (ref) => FormController(ref.read));

class FormController extends StateNotifier<List> {
  FormController(this._read) : super([]);

  final Reader _read;

  void setForm(form1, form2) {
    state = [form1, form2];
  }

  void setDb() async {
    final form1 = state[0];
    final form2 = state[1];

    var formlist = FormList(
      // id: 0, IDは自動増加
      form1: form1,
      form2: form2,
    );
    await _read(formListDbProvider.notifier).insertFormList(formlist);
  }
}

final viewListProvider =
    StateNotifierProvider.autoDispose<ViewListController, List>(
        (ref) => ViewListController(ref.read));

class ViewListController extends StateNotifier<List> {
  ViewListController(this._read) : super([]);

  final Reader _read;

  void getDb() async {
    List aaa = await _read(formListDbProvider.notifier).getFormList();
    List bbb = [];
    for (var element in aaa) {
      bbb.add(element.toMap());
    }
    state = bbb;
  }

  void clearDb(int id) async {
    _read(formListDbProvider.notifier).deleteFormList(id);
  }
}

final bottomNavProvider = StateProvider((ref) => BottomNav.formPage);

enum BottomNav {
  formPage,
  formListPage,
}
