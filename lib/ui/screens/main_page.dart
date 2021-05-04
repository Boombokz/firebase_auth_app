import 'package:auth_app_with_firebase/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app_with_firebase/constants/text_styles.dart';
import 'package:auth_app_with_firebase/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainPage'),
        centerTitle: true,
        actions: [
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteGenerator.authPage,
                (Route<dynamic> route) => false,
              );
            },
            child: Text(
              'Log out',
              style: TextStyle(color: Colors.amber),
            ),
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is PasswordChangedState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Password was changed"),
            ));
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You are logged in',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(InitialEvent());
                  Navigator.pushNamed(
                      context, RouteGenerator.changePasswordPage);
                },
                child: Text(
                  'Change Password?',
                  style: button.copyWith(
                      color: Colors.blueAccent, letterSpacing: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
