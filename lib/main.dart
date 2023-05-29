import 'package:database_flutter/bloc/photo_bloc/photo_bloc_bloc.dart';
import 'package:database_flutter/bloc/student_bloc/student_bloc_bloc.dart';
import 'package:database_flutter/core/color/color.dart';
import 'package:database_flutter/pages/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'db/model/data_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  await Hive.openBox<StudentModel>('Student_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PhotoBloc()),
        BlocProvider(create: (context) => StudentBloc())
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple, fontFamily: inder),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
