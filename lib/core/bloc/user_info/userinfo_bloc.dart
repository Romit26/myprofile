import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/repository/preference_repository.dart';

part 'userinfo_event.dart';

part 'userinfo_state.dart';

class UserinfoBloc extends Bloc<UserinfoEvent, UserinfoState> {
  final PreferenceRepository preferenceRepository;

  UserinfoBloc({required this.preferenceRepository})
      : super(const UserinfoState()) {
    on<GetUserInfoEvent>(getPref);
  }

  Future<void> getPref(GetUserInfoEvent event, Emitter<UserinfoState> emit) async {
    emit(UserInfoLoading());
    await preferenceRepository.getPrefString(userLoginKey).then((value) {
      if (value == null) {
        emit(UserInfoSuccess(map: {}));
      } else {
        emit(UserInfoSuccess(map: jsonDecode(value)));
      }
    });
  }
}
