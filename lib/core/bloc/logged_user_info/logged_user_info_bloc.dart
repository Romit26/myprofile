import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/repository/preference_repository.dart';

part 'logged_user_info_event.dart';

part 'logged_user_info_state.dart';

class LoggedUserInfoBloc extends Bloc<LoggedUserInfoEvent, LoggedUserInfoState> {
  final PreferenceRepository preferenceRepository;

  LoggedUserInfoBloc({required this.preferenceRepository})
      : super(const LoggedUserInfoState()) {
    on<GetLoggedUserInfo>(getPref);
  }

  Future<void> getPref(
      GetLoggedUserInfo event, Emitter<LoggedUserInfoState> emit) async {
    emit(LoggedUserInfoLoading());
    await preferenceRepository.getPrefString(userLoginKey).then((value) {
      if (value == null) {
        emit(LoggedUserInfoSuccess(map: {}));
      } else {
        emit(LoggedUserInfoSuccess(map: jsonDecode(value)));
      }
    }).catchError((onError) {
      emit(LoggedUserInfoFailed());
    });
  }
}
