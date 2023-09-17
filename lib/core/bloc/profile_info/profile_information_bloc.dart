import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/repository/preference_repository.dart';

part 'profile_information_event.dart';

part 'profile_information_state.dart';

class ProfileInformationBloc
    extends Bloc<ProfileInformationEvent, ProfileInformationState> {
  final PreferenceRepository preferenceRepository;

  ProfileInformationBloc({required this.preferenceRepository})
      : super(ProfileInformationState()) {
    on<GetProfileInfoEvent>(getPref);
  }

  Future<void> getPref(
      GetProfileInfoEvent event, Emitter<ProfileInformationState> emit) async {
    emit(ProfileInformationLoading());
    await preferenceRepository.getPrefString(userInfoKey).then((value) {
      if (value == null) {
        emit(ProfileInformationSuccess(map: {}));
      } else {
        emit(ProfileInformationSuccess(map: jsonDecode(value)));
      }
    });
  }
}
