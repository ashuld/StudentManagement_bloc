import 'dart:io';

import 'package:database_flutter/bloc/student_bloc/student_bloc_bloc.dart';
import 'package:database_flutter/db/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentDetails extends StatelessWidget {
  final int index;
  const StudentDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentInitialState) {
            return const CircularProgressIndicator();
          }
          StudentModel data = state.studentList[index];
          return ListView(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: FileImage(
                      File(data.photo),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 90,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90, right: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Age : ${data.age}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Phone :${data.phonenumber}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Place : ${data.place}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
