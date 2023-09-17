part of 'logged_user_info_bloc.dart';
class LoggedUserInfoState extends Equatable {
  const LoggedUserInfoState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoggedUserInfoInitial extends LoggedUserInfoState {
  @override
  List<Object> get props => [];
}

class LoggedUserInfoLoading extends LoggedUserInfoState {
  @override
  List<Object> get props => [];
}

class LoggedUserInfoSuccess extends LoggedUserInfoState {
  Map<String,dynamic> map={};
  LoggedUserInfoSuccess({required this.map});
  @override
  List<Object> get props => [];
}

class LoggedUserInfoFailed extends LoggedUserInfoState {
  @override
  List<Object> get props => [];
}
