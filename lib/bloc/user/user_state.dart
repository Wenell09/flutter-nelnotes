part of 'user_bloc.dart';

sealed class UserState extends Equatable {}

final class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserLoading extends UserState {
  @override
  List<Object?> get props => [];
}

final class UserLoaded extends UserState {
  final List<UserModel> user;
  UserLoaded({required this.user});
  @override
  List<Object?> get props => [user];
}

final class UserEror extends UserState {
  final String error;
  UserEror({required this.error});
  @override
  List<Object?> get props => [];
}
