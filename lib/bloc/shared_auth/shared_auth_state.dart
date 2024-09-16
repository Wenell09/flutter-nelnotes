part of 'shared_auth_bloc.dart';

abstract class SharedAuthState extends Equatable {
  const SharedAuthState();

  @override
  List<Object> get props => [];
}

class SharedAuthInitial extends SharedAuthState {}

class SharedAuthLoaded extends SharedAuthState {
  final String userId;

  const SharedAuthLoaded({required this.userId});

  @override
  List<Object> get props => [userId];
}

class SharedAuthEmpty extends SharedAuthState {}
