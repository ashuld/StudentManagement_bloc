part of 'student_bloc_bloc.dart';

abstract class StudentEvent {}

class LoadingEvent extends StudentEvent {}

class AddStudentEvent extends StudentEvent {
  String name;
  String age;
  String phonenumber;
  String place;
  String imagepath;

  AddStudentEvent(
      {required this.name,
      required this.age,
      required this.phonenumber,
      required this.place,
      required this.imagepath});
}

class UpdateStudentEvent extends StudentEvent {
  int index;
  String name;
  String age;
  String phonenumber;
  String place;
  String imagepath;

  UpdateStudentEvent(
      {required this.index,
      required this.name,
      required this.age,
      required this.phonenumber,
      required this.place,
      required this.imagepath});
}

class DeleteStudentEvent extends StudentEvent {
  int index;

  DeleteStudentEvent({required this.index});
}

class SearchStudentEvent extends StudentEvent {
  String query;
  SearchStudentEvent({required this.query});
}

class OnSearchClosed extends StudentEvent {}
