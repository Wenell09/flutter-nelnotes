part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {}

final class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthSuccess extends AuthState {
  final String userId;
  AuthSuccess({required this.userId});
  @override
  List<Object?> get props => [userId];
}

final class AuthReset extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});

  @override
  List<Object?> get props => [error];
}
