import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_nelnotes/data/models/note_model.dart';
import 'package:flutter_nelnotes/repository/note_repository.dart';

part 'search_note_event.dart';
part 'search_note_state.dart';

class SearchNoteBloc extends Bloc<SearchNoteEvent, SearchNoteState> {
  final NoteRepository _noteRepository;
  SearchNoteBloc(this._noteRepository) : super(SearchNoteInitial()) {
    on<SearchNote>((event, emit) async {
      emit(SearchNoteLoading());
      try {
        final note =
            await _noteRepository.searchNote(event.userId, event.title);
        emit(SearchNoteLoaded(note: note));
      } catch (e) {
        emit(SearchNoteError());
      }
    });
  }
}
