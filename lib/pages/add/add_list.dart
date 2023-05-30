// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:database_flutter/bloc/photo_bloc/photo_bloc_bloc.dart';
import 'package:database_flutter/bloc/student_bloc/student_bloc_bloc.dart';
import 'package:database_flutter/core/color/color.dart';
import 'package:database_flutter/core/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStudents extends StatelessWidget {
  AddStudents({super.key});

  TextEditingController nameController = TextEditingController();

  TextEditingController ageCOntroller = TextEditingController();

  TextEditingController placeCOntroller = TextEditingController();

  TextEditingController phoneNumberCOntroller = TextEditingController();

  File? photo;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: black,
            )),
        backgroundColor: white,
        title: const Text('Add Details', style: TextStyle(color: black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  BlocBuilder<PhotoBloc, PhotoState>(
                    builder: (context, state) {
                      if (state is PhotoLoaded) {
                        photo = state.photo;
                      }
                      return Align(
                          alignment: Alignment.topCenter,
                          child: photo == null
                              ? const CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/ava3.webp',
                                  ),
                                  radius: 60,
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(
                                    File(photo!.path),
                                  ),
                                ));
                    },
                  ),
                  box10(),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<PhotoBloc>().add(PhotoSelectedEvent());
                    },
                    icon: const Icon(Icons.image),
                    label: const Text('Add Image'),
                  ),
                  box10(),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Student Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  box20(),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: ageCOntroller,
                    maxLength: 2,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Age',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Age is required';
                      }
                      return null;
                    },
                  ),
                  box10(),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: phoneNumberCOntroller,
                    maxLength: 10,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone number is required';
                      } else if (value.length < 10) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                  box10(),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: placeCOntroller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Place',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Place is required';
                      }

                      return null;
                    },
                  ),
                  box10(),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (photo != null) {
                          onAddStudentButtonClicked(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text('${nameController.text} Added'),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        } else {
                          imageSnackBar(context);
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonClicked(BuildContext context) async {
    final name = nameController.text.trim();
    final age = ageCOntroller.text.trim();
    final phone = phoneNumberCOntroller.text.trim();
    final place = placeCOntroller.text.trim();
    final image = photo;

    BlocProvider.of<StudentBloc>(context).add(AddStudentEvent(
        name: name,
        age: age,
        phonenumber: phone,
        place: place,
        imagepath: image!.path));
    context.read<PhotoBloc>().add(PhotoResetEvent());
    Navigator.of(context).pop();
  }

  Future<void> imageSnackBar(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30),
        content: Text('Add image'),
      ),
    );
  }
}
