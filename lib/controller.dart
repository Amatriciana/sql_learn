import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';

final formProvider =
    StateNotifierProvider<FormController, List>((ref) => FormController());

class FormController extends StateNotifier<List> {
  FormController() : super([]);

  void setForm(form1, form2) {
    state = [form1, form2];
  }
}

final bottomNavProvider = StateProvider((ref) => BottomNav.formPage);

enum BottomNav {
  formPage,
  formListPage,
}

final listViewProvider = StateNotifierProvider<ListViewController, List>(
    (ref) => ListViewController(ref.read));

class ListViewController extends StateNotifier<List> {
  ListViewController(this._read) : super([]);

  final Reader _read;
}
