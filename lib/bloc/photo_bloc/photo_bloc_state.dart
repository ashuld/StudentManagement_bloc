part of 'photo_bloc_bloc.dart';

abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final File? photo;

  PhotoLoaded({required this.photo});
}
