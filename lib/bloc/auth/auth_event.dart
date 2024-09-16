part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {}

class AuthLogin extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthLogout extends AuthEvent {
  @override
  List<Object?> get props => [];
}
