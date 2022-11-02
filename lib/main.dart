import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/firebase_options.dart';
import 'package:task_project/repositories/firebase_auth_repository.dart';
import 'package:task_project/repositories/network_repository.dart';
import 'package:task_project/screens/auth/login_screen.dart';
import 'package:task_project/screens/home/home_screen.dart';

import 'bloc/authentication_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NetworkRepository(),
      child: BlocProvider(
        create: (context) => AuthenticationBloc(FirebaseAuthRepository()),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginScreen(),
        ),
      ),
    );
  }
}
