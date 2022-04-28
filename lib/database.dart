import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql_learn/main.dart';

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

  @override
  String toString() {
    return 'FormList{id: $id, form1: $form1, form2: $form2}';
  }
}

final formListDbProvider = StateNotifierProvider<FormListDbController, List>(
    (ref) => FormListDbController(ref.read));

class FormListDbController extends StateNotifier<List> {
  FormListDbController(this._read) : super([]);

  final Reader _read;

  // Create
  Future<void> insertFormList(FormList formlist) async {
    final Database db = await _read(databaseProvider);
    await db.insert(
      'formlist',
      formlist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read
  Future<List<FormList>> getFormList() async {
    final Database db = await _read(databaseProvider);
    final List<Map<String, dynamic>> maps = await db.query('formlist');
    return List.generate(maps.length, (i) {
      return FormList(
        id: maps[i]['id'],
        form1: maps[i]['form1'],
        form2: maps[i]['form2'],
      );
    });
  }

  // Update
  Future<void> updateFormList(FormList formlist) async {
    final db = await _read(databaseProvider);
    await db.update(
      'formlist',
      formlist.toMap(),
      where: "id = ?",
      whereArgs: [formlist.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  // Delete
  Future<void> deleteFormList(int id) async {
    final db = await _read(databaseProvider);
    await db.delete(
      'formlist',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
