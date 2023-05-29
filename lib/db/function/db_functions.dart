// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:database_flutter/db/model/data_model.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<StudentModel>> studentLIstNotifier = ValueNotifier([]);
Future<void> addStudents(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  //adding database
  final idb = await studentDB.add(value);
  value.id = idb;
  studentLIstNotifier.value.add(value);
  studentLIstNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  studentLIstNotifier.value.clear();
  studentLIstNotifier.value.addAll(studentDB.values);
  studentLIstNotifier.notifyListeners();
}

Future<void> deleteStudent(int index) async {
  final studentDB = await Hive.openBox<StudentModel>('Student_db');
  studentDB.deleteAt(index);
  getAllStudents();
}

Future<void> editStudent(int id, StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentDB.putAt(id, value);
  getAllStudents();
}

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
