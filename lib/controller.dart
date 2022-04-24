import 'package:hooks_riverpod/hooks_riverpod.dart';

final formProvider =
    StateNotifierProvider<FormController, List>((ref) => FormController());

class FormController extends StateNotifier<List> {
  FormController() : super([]);

  void setForm(form1, form2) {
    state = [form1, form2];
  }
}
