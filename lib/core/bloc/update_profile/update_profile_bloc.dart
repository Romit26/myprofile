import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myprofile/core/constant/key_constant.dart';
import 'package:myprofile/core/repository/preference_repository.dart';

part 'update_profile_event.dart';

part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final PreferenceRepository preferenceRepository;

  UpdateProfileBloc({required this.preferenceRepository})
      : super(const UpdateProfileState()) {
    on<UpdateProfileUserEvent>(userUpdate);
  }

  Future<void> userUpdate(
      UpdateProfileUserEvent event, Emitter<UpdateProfileState> emit) async {
    emit(UpdateProfileLoading());
    await preferenceRepository
        .setString(userInfoKey, jsonEncode(event.map))
        .then((value) {
      emit(UpdateProfileSuccess());
    }).catchError((onError) {
      emit(UpdateProfileFailed());
    }).onError((error, stackTrace) {});
  }
}
