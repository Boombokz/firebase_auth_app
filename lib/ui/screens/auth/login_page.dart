import 'package:auth_app_with_firebase/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app_with_firebase/ui/components/buttons/circle_button.dart';
import 'package:auth_app_with_firebase/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
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
          title: Text('Login page'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 22),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter Email',
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: passwordController,
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  labelText: 'Password',
                  hintText: 'Enter password',
                ),
              ),
              SizedBox(height: 30),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthInitial) {
                    return CircleButton(
                        title: 'Login',
                        isLoading: false,
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                              email: emailController.text,
                              password: passwordController.text));
                        });
                  } else if (state is AuthLoadingState) {
                    return CircleButton(
                        title: 'Login', isLoading: true, onPressed: () {});
                  } else if (state is AuthErrorState) {
                    return CircleButton(
                        title: '${state.errorMessage}',
                        isLoading: false,
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                              email: emailController.text,
                              password: passwordController.text));
                        });
                  } else {
                    return Offstage();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
