import 'package:hooks_riverpod/hooks_riverpod.dart';

final formProvider =
    StateNotifierProvider<FormController, int>((ref) => FormController());

class FormController extends StateNotifier<int> {
  FormController() : super(0);

  void add(form1, form2) {
    state = int.parse(form1) + int.parse(form2);
  }
}
