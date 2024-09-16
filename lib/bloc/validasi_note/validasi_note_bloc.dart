import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'validasi_note_event.dart';
part 'validasi_note_state.dart';

class ValidasiNoteBloc extends Bloc<ValidasiNoteEvent, ValidasiNoteState> {
  ValidasiNoteBloc()
      : super(ValidasiNoteInitial(
          isValidate: false,
          isSuccess: false,
        )) {
    on<ValidasiNote>((event, emit) {
      if (event.title.isEmpty || event.deskripsi.isEmpty) {
        emit(ValidasiNoteInitial(
          isValidate: false,
          isSuccess: false,
        ));
      } else {
        emit(ValidasiNoteInitial(
          isValidate: true,
          isSuccess: false,
        ));
      }
    });
    on<ValidasiNoteEnd>((event, emit) => emit(ValidasiNoteInitial(
          isValidate: false,
          isSuccess: true,
        )));
  }
}
