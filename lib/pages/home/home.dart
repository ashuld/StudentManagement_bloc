import 'package:database_flutter/core/color/color.dart';
import 'package:database_flutter/pages/add/add_list.dart';
import 'package:database_flutter/pages/search/search.dart';
import 'package:database_flutter/widgets/listview.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: black),
        ),
        backgroundColor: white,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchStudent());
            },
            icon: const Icon(
              Icons.search,
              color: black,
            ),
          ),
        ],
      ),
      body: const SafeArea(
        child: ListViewWidget(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Student'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudents(),
            ),
          );
        },
      ),
    );
  }
}
