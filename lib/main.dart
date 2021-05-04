import 'package:auth_app_with_firebase/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app_with_firebase/utils/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Auth App',
        debugShowCheckedModeBanner: false,
        initialRoute: RouteGenerator.authPage,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
