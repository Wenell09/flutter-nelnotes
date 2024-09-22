part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {}

class GetNote extends NoteEvent {
  final String userId;
  GetNote({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class AddNote extends NoteEvent {
  final String userId, title, deskripsi;
  AddNote({
    required this.userId,
    required this.title,
    required this.deskripsi,
  });
  @override
  List<Object?> get props => [userId, title, deskripsi];
}

class EditNote extends NoteEvent {
  final String userId, noteId, title, deskripsi;
  EditNote({
    required this.userId,
    required this.noteId,
    required this.title,
    required this.deskripsi,
  });
  @override
  List<Object?> get props => [userId, noteId, title, deskripsi];
}

class DeleteNote extends NoteEvent {
  final String userId, noteId;
  DeleteNote({required this.userId, required this.noteId});
  @override
  List<Object?> get props => [userId, noteId];
}

class AddPin extends NoteEvent {
  final String userId, noteId;
  AddPin({required this.userId, required this.noteId});

  @override
  List<Object?> get props => [userId, noteId];
}

class DeletePin extends NoteEvent {
  final String userId, noteId;
  DeletePin({required this.userId, required this.noteId});

  @override
  List<Object?> get props => [userId, noteId];
}
