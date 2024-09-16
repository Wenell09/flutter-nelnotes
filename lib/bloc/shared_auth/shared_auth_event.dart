part of 'shared_auth_bloc.dart';

sealed class SharedAuthEvent extends Equatable {}

class SharedAuthLoad extends SharedAuthEvent {
  @override
  List<Object?> get props => [];
}

class SharedAuthSave extends SharedAuthEvent {
  final String userId;
  SharedAuthSave({required this.userId});
  @override
  List<Object?> get props => [userId];
}
