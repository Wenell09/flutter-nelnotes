import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'layout_event.dart';
part 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  LayoutBloc() : super(const LayoutState(isGrid: true)) {
    on<LayoutLoad>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final isGrid = prefs.getBool("isGrid") ?? true;
      emit(LayoutState(isGrid: isGrid));
    });
    on<LayoutSave>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isGrid", !state.isGrid);
      emit(LayoutState(isGrid: !state.isGrid));
    });
  }
}
