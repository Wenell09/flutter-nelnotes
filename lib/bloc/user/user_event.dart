part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {}

class GetUser extends UserEvent {
  final String userId;
  GetUser({required this.userId});
  @override
  List<Object> get props => [];
}
