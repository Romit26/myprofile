part of 'userinfo_bloc.dart';

abstract class UserinfoEvent extends Equatable {
  const UserinfoEvent();
}

class GetUserInfoEvent extends UserinfoEvent {
  final String key;
  const GetUserInfoEvent({required this.key});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
