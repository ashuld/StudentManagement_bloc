import 'dart:io';

import 'package:database_flutter/bloc/student_bloc/student_bloc_bloc.dart';
import 'package:database_flutter/pages/details/std_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchStudent extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear, color: Colors.black),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back, color: Colors.black),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
        builder: ((BuildContext context, StudentState state) {
      if (state is LoadingState) {
        return ListView.builder(
            itemBuilder: (context, index) {
              final data = state.studentList[index];
              if (data.name.toLowerCase().contains(query.toLowerCase())) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentDetails(index: index),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          File(data.photo),
                        ),
                      ),
                      title: Text(data.name),
                    ),
                    const Divider()
                  ],
                );
              } else {
                return Container();
              }
            },
            itemCount: state.studentList.length);
      } else {
        return const Center(
          child: Text(
            'No Record Found',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      }
    }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
        builder: ((BuildContext context, StudentState state) {
      if (state is LoadingState) {
        return ListView.builder(
            itemBuilder: (context, index) {
              final data = state.studentList[index];
              if (data.name.toLowerCase().contains(query.toLowerCase())) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentDetails(index: index),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          File(data.photo),
                        ),
                      ),
                      title: Text(data.name),
                    ),
                    const Divider()
                  ],
                );
              } else {
                return Container();
              }
            },
            itemCount: state.studentList.length);
      } else {
        return const Center(
          child: Text(
            'No Record Found',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        );
      }
    }));
  }
}
