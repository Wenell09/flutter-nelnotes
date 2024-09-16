import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_nelnotes/data/models/note_model.dart';
import 'package:flutter_nelnotes/repository/note_repository.dart';

part 'detail_note_event.dart';
part 'detail_note_state.dart';

class DetailNoteBloc extends Bloc<DetailNoteEvent, DetailNoteState> {
  final NoteRepository _noteRepository;
  DetailNoteBloc(this._noteRepository) : super(DetailNoteInitial()) {
    on<GetDetailNote>((event, emit) async {
      emit(DetailNoteLoading());
      try {
        final detailNote =
            await _noteRepository.fetchDetailNote(event.userId, event.noteId);
        emit(DetailNoteLoaded(detailNote: detailNote));
      } catch (e) {
        emit(DetailNoteError(error: e.toString()));
      }
    });
  }
}
