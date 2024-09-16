import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nelnotes/data/models/user_model.dart';
import 'package:flutter_nelnotes/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  UserBloc(this._userRepository) : super(UserInitial()) {
    on<GetUser>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await _userRepository.getUser(event.userId);
        debugPrint("hasil user:${user.length}");
        emit(UserLoaded(user: user));
      } catch (e) {
        emit(UserEror(error: e.toString()));
      }
    });
  }
}
