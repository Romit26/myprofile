import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/repository/preference_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PreferenceRepository preferenceRepository;

  LoginBloc({required this.preferenceRepository}) : super(const LoginState()) {
    on<LoginUserEvent>(userLogin);
    on<GoogleLoginUserEvent>(userGoogleLogin);
  }

  Future<void> userLogin(LoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await preferenceRepository
        .setString(userLoginKey, jsonEncode(event.map))
        .then((value) {
      emit(LoginSuccess());
    }).catchError((onError) {
      emit(LoginFailed());
    }).onError((error, stackTrace) {
    });
  }

  Future<void> userGoogleLogin(
      GoogleLoginUserEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await signInWithGoogle().then((value) async {
      await preferenceRepository
          .setString(userLoginKey, jsonEncode(event.map))
          .then((value) {
        emit(LoginSuccess());
      });
    }).catchError((onError) {
      emit(LoginFailed());
    }).onError((error, stackTrace) {
      emit(LoginFailed());
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
