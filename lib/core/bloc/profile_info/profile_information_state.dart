part of 'profile_information_bloc.dart';

@immutable
class ProfileInformationState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProfileInformationInitial extends ProfileInformationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProfileInformationLoading extends ProfileInformationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProfileInformationSuccess extends ProfileInformationState {
  Map<String, dynamic>? map;

  ProfileInformationSuccess({this.map});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProfileInformationEmpty extends ProfileInformationState {
  Map<String, dynamic> map = {};

  ProfileInformationEmpty({required this.map});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ProfileInformationFailed extends ProfileInformationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
