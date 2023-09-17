part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();
}

class UpdateProfileUserEvent extends UpdateProfileEvent {
  Map<String, dynamic> map;

  UpdateProfileUserEvent({required this.map});

  @override
  List<Object?> get props => [];
}
