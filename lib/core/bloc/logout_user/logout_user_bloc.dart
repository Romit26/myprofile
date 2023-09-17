import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/repository/preference_repository.dart';

part 'logout_user_event.dart';

part 'logout_user_state.dart';

class LogoutUserBloc extends Bloc<LogoutUserEvent, LogoutUserState> {
  final PreferenceRepository preferenceRepository;

  LogoutUserBloc({required this.preferenceRepository})
      : super(const LogoutUserState()) {
    on<LogoutUserClickEvent>(logoutUser);
  }

  Future<void> logoutUser(
      LogoutUserClickEvent event, Emitter<LogoutUserState> emit) async {
    emit(LogoutUserLoading());
    await preferenceRepository.removeValue(userInfoKey);
    String? userInfo = await preferenceRepository.getPrefString(userLoginKey);
    Map<String, dynamic> map = jsonDecode(userInfo!);
    if (map[loginType] == googleLogin) {
      await preferenceRepository.removeValue(userLoginKey);
      await GoogleSignIn().signOut();
      emit(LogoutUserSuccess());
    } else {
      if (map[rememberMe] == true) {
        map[userLoggedOut] = true;
        await preferenceRepository.setString(userLoginKey, jsonEncode(map));
        emit(LogoutUserSuccess());
      } else {
        await preferenceRepository.removeValue(userLoginKey);
        emit(LogoutUserSuccess());
      }
    }
  }
}
