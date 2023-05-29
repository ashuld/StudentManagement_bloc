import 'package:database_flutter/bloc/student_bloc/student_bloc_bloc.dart';
import 'package:database_flutter/core/color/color.dart';
import 'package:database_flutter/db/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

deleteDialogue(int index, BuildContext context, StudentModel data) {
  return showDialog(
    context: context,
    builder: (ctx1) {
      return AlertDialog(
        backgroundColor: white,
        title: const Text(
          'Are You Sure',
          style: TextStyle(color: black),
        ),
        content: Text(
          'Delete ${data.name.toUpperCase()} ?',
          style: const TextStyle(color: black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<StudentBloc>(context).add(DeleteStudentEvent(index: index));
              Navigator.of(ctx1).pop();
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: black),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'No..',
              style: TextStyle(color: black),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> showSnackbarMessage(BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(30),
      content: Text('Items are required')));
}