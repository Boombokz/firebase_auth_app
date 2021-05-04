import 'package:auth_app_with_firebase/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app_with_firebase/constants/text_styles.dart';
import 'package:auth_app_with_firebase/ui/components/buttons/circle_button.dart';
import 'package:auth_app_with_firebase/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordRecoveredState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Password recovery request send to your email"),
          ));
        }
        if (state is LoggedInState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteGenerator.mainPage,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Auth with Firebase'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                  'https://firebase.google.com/downloads/brand-guidelines/PNG/logo-built_white.png'),
              SizedBox(height: 36),
              CircleButton(
                title: 'Login',
                isLoading: false,
                onPressed: () {
                  Navigator.pushNamed(context, RouteGenerator.loginPage);
                  BlocProvider.of<AuthBloc>(context).add(InitialEvent());
                },
              ),
              SizedBox(height: 18),
              CircleButton(
                title: 'Register',
                isLoading: false,
                onPressed: () {
                  Navigator.pushNamed(context, RouteGenerator.registerPage);
                  BlocProvider.of<AuthBloc>(context).add(InitialEvent());
                },
              ),
              SizedBox(height: 18),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(InitialEvent());
                  Navigator.pushNamed(
                      context, RouteGenerator.recoveryPasswordPage);
                },
                child: Text(
                  'Forgot Password?',
                  style: button.copyWith(
                      color: Colors.blueAccent, letterSpacing: 1),
                ),
              ),
              SignInButton(
                Buttons.Facebook,
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context)
                      .add(LoginWithFacebookEvent());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
