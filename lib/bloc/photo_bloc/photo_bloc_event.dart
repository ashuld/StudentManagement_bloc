part of 'photo_bloc_bloc.dart';

abstract class PhotoEvent {}

class PhotoSelectedEvent extends PhotoEvent {}

class PhotoResetEvent extends PhotoEvent {}
