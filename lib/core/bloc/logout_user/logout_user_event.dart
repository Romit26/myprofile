part of 'logout_user_bloc.dart';

abstract class LogoutUserEvent extends Equatable {
  const LogoutUserEvent();
}

class LogoutUserClickEvent extends LogoutUserEvent {
  const LogoutUserClickEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
