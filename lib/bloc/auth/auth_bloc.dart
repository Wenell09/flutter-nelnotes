import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_nelnotes/repository/auth_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final userId = await _authRepository.login();
        emit(AuthSuccess(userId: userId.toString()));
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
    on<AuthLogout>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.logout();
        emit(AuthReset());
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
  }
}
