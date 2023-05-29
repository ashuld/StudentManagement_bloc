import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'photo_bloc_event.dart';
part 'photo_bloc_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoInitial()) {
    on<PhotoSelectedEvent>((event, emit) async {
      final photo = await getPhoto();
      emit(PhotoLoaded(photo: photo));
    });

    on<PhotoResetEvent>((event, emit) {
      emit(PhotoInitial());
    });
  }

  Future<File?> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return null;
    } else {
      final phototemp = File(photo.path);
      return phototemp;
    }
  }
}
