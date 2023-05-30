import 'dart:io';

import 'package:database_flutter/bloc/student_bloc/student_bloc_bloc.dart';
import 'package:database_flutter/core/color/color.dart';
import 'package:database_flutter/db/model/data_model.dart';
import 'package:database_flutter/pages/details/std_details.dart';
import 'package:database_flutter/pages/edit/std_edit.dart';
import 'package:database_flutter/widgets/deletedialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<StudentBloc>(context).add(StudentLoadingEvent());
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        List<StudentModel> studentlist = state.studentList;
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = studentlist[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetails(
                      index: index,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundImage: FileImage(
                  File(data.photo),
                ),
              ),
              title: Text(data.name),
              trailing: Wrap(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditStudents(studentObj: data, index: index),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteDialogue(index, context, data);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: black,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 1,
              color: Colors.grey,
            );
          },
          itemCount: studentlist.length,
        );
      },
    );
  }
}
