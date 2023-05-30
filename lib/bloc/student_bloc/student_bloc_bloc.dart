import 'package:bloc/bloc.dart';
import 'package:database_flutter/db/function/db_functions.dart';
import 'package:database_flutter/db/model/data_model.dart';

part 'student_bloc_event.dart';
part 'student_bloc_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final List<StudentModel> studentData = [];

  StudentBloc() : super(StudentInitialState()) {
    on<LoadingEvent>((event, emit) async {
      // debugPrint('Loading');
      final studentDatafromDB = DatabaseRepo.getOpenedBox().values.toList();
      studentData.clear();
      studentData.addAll(studentDatafromDB);
      emit(LoadingState(studentData));
    });

    on<AddStudentEvent>((event, emit) async {
      StudentModel studentobj = StudentModel(
          name: event.name,
          age: event.age,
          phonenumber: event.phonenumber,
          place: event.place,
          photo: event.imagepath);
      DatabaseRepo.addStudent(studentobj);

      add(LoadingEvent());

      // debugPrint('Student Added');
    });

    on<UpdateStudentEvent>((event, emit) async {
      StudentModel studentobj = StudentModel(
          name: event.name,
          age: event.age,
          phonenumber: event.phonenumber,
          place: event.place,
          photo: event.imagepath);

      DatabaseRepo.updateStudent(event.index, studentobj);
      add(LoadingEvent());
      // debugPrint('Student updated');
    });

    on<DeleteStudentEvent>((event, emit) async {
      DatabaseRepo.deleteStudent(event.index);
      add(LoadingEvent());
      // debugPrint('deleted');
    });

    on<SearchStudentEvent>((event, emit) async {
      // debugPrint('searching');

      List<StudentModel> searchOutput =
          await DatabaseRepo.searchStudent(event.query);
      emit(StudentSearchState(searchOutput));
    });

    on<OnSearchClosed>((event, emit) {
      add(LoadingEvent());
    });
  }
}
