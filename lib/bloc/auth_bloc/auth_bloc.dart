import 'dart:async';
import 'package:auth_app_with_firebase/helpers/facebook_login_helper.dart';
import 'package:auth_app_with_firebase/helpers/firebase_auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  FacebookLoginHelper facebookLoginHelper = FacebookLoginHelper();
  FirebaseAuthHelper firebaseAuthHelper = FirebaseAuthHelper();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is InitialEvent) {
      yield AuthInitial();
    }
    if (event is RegisterEvent) {
      yield AuthLoadingState();
      try {
        await firebaseAuthHelper.registerUser(event.email, event.password);
        yield RegisteredState();
      } on FirebaseAuthException catch (signUpError) {
        if (signUpError.code == 'email-already-in-use') {
          yield AuthErrorState(
              errorMessage: 'User with this email already exists');
        } else {
          yield AuthErrorState(errorMessage: signUpError.code.toString());
        }
      } catch (e) {
        yield AuthErrorState(errorMessage: 'Register is failed, please retry');
      }
    }
    if (event is LoginEvent) {
      yield AuthLoadingState();
      try {
        await firebaseAuthHelper.loginUser(event.email, event.password);
        yield LoggedInState();
      } on FirebaseAuthException catch (loginError) {
        if (loginError.code == 'error-user-not-found') {
          yield AuthErrorState(
              errorMessage: 'User with this email doesn\'t exists');
        } else {
          yield AuthErrorState(errorMessage: loginError.code.toString());
        }
      } catch (e) {
        yield AuthErrorState(errorMessage: 'Login is failed, please retry');
      }
    }
    if (event is RecoveryPasswordEvent) {
      try {
        await firebaseAuthHelper.passwordRecovery(event.email);
        yield PasswordRecoveredState();
      } catch (e) {
        yield AuthErrorState(errorMessage: 'Error! Request is not send');
      }
    }
    if (event is LoginWithFacebookEvent) {
      yield AuthLoadingState();
      try {
        await facebookLoginHelper.signInWithFacebook();
        yield LoggedInState();
      } catch (e) {
        yield AuthErrorState(errorMessage: 'Login failed');
      }
    }
    if (event is LogOutEvent) {
      try {
        await firebaseAuthHelper.logOutUser();
        yield AuthInitial();
      } catch (e) {
        yield AuthErrorState(errorMessage: 'Logout Failed');
      }
    }
    if (event is ChangePasswordEvent) {
      try {
        await firebaseAuthHelper.changePassword(event.newPassword);
        yield PasswordChangedState();
      } catch (e) {
        yield AuthErrorState(errorMessage: 'Failed');
      }
    }
  }
}
