part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  Map<String,dynamic> map={};

  LoginUserEvent({required this.map});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GoogleLoginUserEvent extends LoginEvent {
  Map<String,dynamic> map={};

  GoogleLoginUserEvent({required this.map});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
