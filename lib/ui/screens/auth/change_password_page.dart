import 'package:auth_app_with_firebase/bloc/auth_bloc/auth_bloc.dart';
import 'package:auth_app_with_firebase/ui/components/buttons/circle_button.dart';
import 'package:auth_app_with_firebase/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatedPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is PasswordChangedState) {
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
          title: Text('Password Change'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 22),
          child: Column(
            children: [
              TextFormField(
                controller: newPasswordController,
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  labelText: 'New Password',
                  hintText: 'Enter new password',
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: repeatedPasswordController,
                textAlign: TextAlign.center,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  labelText: 'Repeat New Password',
                  hintText: 'Repeat new password',
                ),
              ),
              SizedBox(height: 30),
              CircleButton(
                  title: 'Change Password',
                  isLoading: false,
                  onPressed: () {
                    if (newPasswordController.text ==
                        repeatedPasswordController.text) {
                      BlocProvider.of<AuthBloc>(context).add(
                          ChangePasswordEvent(
                              newPassword: repeatedPasswordController.text));

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Password are not equal"),
                      ));
                    }
                  }),
              // BlocBuilder<AuthBloc, AuthState>(
              //   builder: (context, state) {
              //     if (state is AuthInitial) {
              //       return CircleButton(
              //           title: 'Change Password',
              //           isLoading: false,
              //           onPressed: () {
              //             if(formKey.currentState!.validate()) {
              //              Navigator.pop(context);
              //             }
              //           });
              //     } else if (state is AuthLoadingState) {
              //       return CircleButton(
              //           title: 'Change Password',
              //           isLoading: true,
              //           onPressed: () {});
              //     } else if (state is AuthErrorState) {
              //       return CircleButton(
              //           title: '${state.errorMessage}',
              //           isLoading: false,
              //           onPressed: () {});
              //     } else {
              //       return Offstage();
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
