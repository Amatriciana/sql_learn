import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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

  @override
  String toString() {
    return 'FormList{id: $id, form1: $form1, form2: $form2}';
  }
}

final formListDbProvider =
    StateNotifierProvider<FormListDb, Map>((ref) => FormListDb());

class FormListDb extends StateNotifier<Map> {
  FormListDb() : super({});

  dynamic database;

  void test1(form1, form2) async {
    var formlist = FormList(
      id: 0,
      form1: form1,
      form2: form2,
    );
    await insertFormList(formlist);
    List test3 = await getFormList();
    state = test3[0].toMap();
  }

  void formListdatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'formlist_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE formlist(id INTEGER PRIMARY KEY, form1 TEXT, form2 TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertFormList(FormList formlist) async {
    final Database db = await database;
    await db.insert(
      'formlist',
      formlist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FormList>> getFormList() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('formlist');
    return List.generate(maps.length, (i) {
      return FormList(
        id: maps[i]['id'],
        form1: maps[i]['form1'],
        form2: maps[i]['form2'],
      );
    });
  }

  Future<void> updateFormList(FormList formlist) async {
    final db = await database;
    await db.update(
      'formlist',
      formlist.toMap(),
      where: "id = ?",
      whereArgs: [formlist.id],
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<void> deleteFormList(int id) async {
    final db = await database;
    await db.delete(
      'formlist',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // var formlist = FormList(
  // id: 0,
  // form1: 'フォーム１',
  // form2: 'フォーム２',
  // );

  // await insertFormList(formlist);

  // print(await getFormList());

  //formlist = FormList(
  //  id: formlist.id,
  // form1: formlist.form1,
  //form2: formlist.form2,
  //);

  // await updateFormList(formlist);

  // print(await getFormList());

  // await deleteFormList(formlist.id);

  //print(await getFormList());
}
