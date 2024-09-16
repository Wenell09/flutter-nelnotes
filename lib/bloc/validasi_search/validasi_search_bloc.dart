import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'validasi_search_event.dart';
part 'validasi_search_state.dart';

class ValidasiSearchBloc
    extends Bloc<ValidasiSearchEvent, ValidasiSearchState> {
  ValidasiSearchBloc()
      : super(const ValidasiSearchState(isShowButtonClear: false)) {
    on<ShowButtonClear>((event, emit) {
      if (event.title.isEmpty) {
        emit(const ValidasiSearchState(isShowButtonClear: false));
      } else {
        emit(const ValidasiSearchState(isShowButtonClear: true));
      }
    });
    on<ClearInput>((event, emit) =>
        emit(const ValidasiSearchState(isShowButtonClear: false)));
  }
}
