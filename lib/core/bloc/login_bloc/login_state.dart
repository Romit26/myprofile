part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {
  @override
  List<Object> get props => [];
}
