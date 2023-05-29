import 'dart:io';
import 'package:database_flutter/bloc/photo_bloc/photo_bloc_bloc.dart';
import 'package:database_flutter/bloc/student_bloc/student_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:database_flutter/pages/home/home.dart';
import 'package:flutter/material.dart';
import '../../db/model/data_model.dart';

// ignore: must_be_immutable
class EditStudents extends StatefulWidget {
  final StudentModel studentObj;
  final int index;
  const EditStudents(
      {super.key, required this.studentObj, required this.index});

  @override
  State<EditStudents> createState() => _EditStudentsState();
}

class _EditStudentsState extends State<EditStudents> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageCOntroller = TextEditingController();
  TextEditingController placeCOntroller = TextEditingController();
  TextEditingController phoneNumberCOntroller = TextEditingController();
  File? photo;
  bool image = true;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.studentObj.name);
    ageCOntroller = TextEditingController(text: widget.studentObj.age);
    phoneNumberCOntroller =
        TextEditingController(text: widget.studentObj.phonenumber);
    placeCOntroller = TextEditingController(text: widget.studentObj.place);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: const Text(
          'Edit Screen',
          style: TextStyle(color: Colors.black),
        ),
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
                          child: image == true
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(
                                    File(widget.studentObj.photo),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(File(photo!.path)),
                                ));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<PhotoBloc>().add(PhotoSelectedEvent());
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit image'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: nameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: 'Student Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                        labelText: 'Age'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Age is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onEditButtonClicked(widget.index, context);
                      }
                    },
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onEditButtonClicked(int index, BuildContext context) async {
    BlocProvider.of<StudentBloc>(context).add(UpdateStudentEvent(
        index: index,
        name: nameController.text,
        age: ageCOntroller.text,
        phonenumber: phoneNumberCOntroller.text,
        place: placeCOntroller.text,
        imagepath: photo?.path ?? widget.studentObj.photo));
    context.read<PhotoBloc>().add(PhotoResetEvent());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(30),
        content: Text('${nameController.text} Updated'),
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ScreenHome(),
      ),
    );
  }
}
