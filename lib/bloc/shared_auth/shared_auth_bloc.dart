import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_auth_event.dart';
part 'shared_auth_state.dart';

class SharedAuthBloc extends Bloc<SharedAuthEvent, SharedAuthState> {
  SharedAuthBloc() : super(SharedAuthInitial()) {
    on<SharedAuthLoad>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString("userId") ?? "";
      if (userId.isEmpty) {
        debugPrint("id empty:$userId");
        emit(SharedAuthEmpty());
      } else {
        debugPrint("id load:$userId");
        emit(SharedAuthLoaded(userId: userId));
      }
    });

    on<SharedAuthSave>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("userId", event.userId);
      debugPrint("id dibuat:${event.userId}");
      emit(SharedAuthLoaded(userId: event.userId));
    });
  }
}
