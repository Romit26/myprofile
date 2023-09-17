part of 'userinfo_bloc.dart';

class UserinfoState extends Equatable {
  const UserinfoState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UserinfoInitial extends UserinfoState {
  @override
  List<Object> get props => [];
}

class UserInfoLoading extends UserinfoState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UserInfoSuccess extends UserinfoState {
  Map<String, dynamic>? map;

  UserInfoSuccess({this.map});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UserInfoEmpty extends UserinfoState {
  Map<String, dynamic> map = {};

  UserInfoEmpty({required this.map});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class UserInfoFailed extends UserinfoState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
