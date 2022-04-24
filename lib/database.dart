import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'main.dart';
import 'controller.dart';

class FormList {
  FormList({required this.id, required this.form1, required this.form2});

  final int id;
  final String form1;
  final String form2;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'form1': form1,
      'form2': form2,
    };
  }
}

final formListDbProvider =
    StateNotifierProvider<FormListDb, List>((ref) => FormListDb(ref.read));

class FormListDb extends StateNotifier<List> {
  FormListDb(this._read) : super([]);

  final Reader _read;

  Future<void> insertFormlist(FormList formlist) async {
    final Database db = await _read(databaseProvider);
    await db.insert(
      'formlist',
      formlist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
