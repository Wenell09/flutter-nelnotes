part of 'detail_note_bloc.dart';

sealed class DetailNoteEvent extends Equatable {}

class GetDetailNote extends DetailNoteEvent {
  final String userId, noteId;
  GetDetailNote({required this.userId, required this.noteId});

  @override
  List<Object?> get props => [userId, noteId];
}
