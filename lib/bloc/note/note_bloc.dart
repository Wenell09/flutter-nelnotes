import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_nelnotes/data/models/note_model.dart';
import 'package:flutter_nelnotes/repository/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository;
  NoteBloc(this._noteRepository) : super(NoteInitial()) {
    on<GetNote>((event, emit) async {
      emit(NoteLoading());
      try {
        final notes = await _noteRepository.fetchNote(event.userId);
        emit(NoteLoaded(notes: notes));
      } catch (e) {
        emit(NoteError(error: e.toString()));
      }
    });
    on<AddNote>((event, emit) async {
      emit(NoteLoading());
      try {
        await _noteRepository.addNote(
          event.userId,
          event.title,
          event.deskripsi,
        );
        emit(NoteAddSuccess(userId: event.userId));
      } catch (e) {
        emit(NoteError(error: e.toString()));
      }
    });

    on<EditNote>((event, emit) async {
      emit(NoteLoading());
      try {
        await _noteRepository.editNote(
          event.userId,
          event.noteId,
          event.title,
          event.deskripsi,
        );
        emit(NoteEditSuccess(userId: event.userId));
      } catch (e) {
        emit(NoteError(error: e.toString()));
      }
    });

    on<DeleteNote>((event, emit) async {
      emit(NoteLoading());
      try {
        await _noteRepository.deleteNote(event.userId, event.noteId);
        emit(NoteDeleteSuccess());
      } catch (e) {
        emit(NoteError(error: e.toString()));
      }
    });
  }
}
