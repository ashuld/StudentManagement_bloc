// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:database_flutter/db/model/data_model.dart';

import 'package:hive_flutter/adapters.dart';

class DatabaseRepo {
  static Box<StudentModel> getOpenedBox() {
    return Hive.box('Student_db');
  }

  static Future<void> addStudent(StudentModel value) async {
    final studentDB = getOpenedBox();
    final id = await studentDB.add(value);
    value.id = id;
  }

  static Future<void> updateStudent(int id, StudentModel value) async {
    final studentDB = getOpenedBox();
    studentDB.putAt(id, value);
  }

  static Future<void> deleteStudent(int id) async {
    final studentDB = getOpenedBox();
    studentDB.deleteAt(id);
  }

  static Future<List<StudentModel>> searchStudent(String query) async {
    final studentDB = getOpenedBox();
    final studentList = studentDB.values;

    final searchOutput = studentList.where((element) {
      String nameVal = element.name;
      return nameVal.toLowerCase().contains(query.toLowerCase().trim());
    });

    return searchOutput.toList();
  }
}
