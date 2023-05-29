part of 'student_bloc_bloc.dart';

abstract class StudentState {
  List<StudentModel> studentList = [];

  StudentState({required this.studentList});
}

class StudentInitialState extends StudentState {
  StudentInitialState() : super(studentList: []);
}

class LoadingState extends StudentState {
  LoadingState(List<StudentModel> studentlist)
      : super(studentList: studentlist);
}

class StudentAddState extends StudentState {
  StudentAddState(List<StudentModel> studentlist)
      : super(studentList: studentlist);
}

class StudentViewState extends StudentState {
  StudentViewState(List<StudentModel> studentlist)
      : super(studentList: studentlist);
}

class StudentSearchState extends StudentState {
  StudentSearchState(List<StudentModel> studentlist)
      : super(studentList: studentlist);
}
