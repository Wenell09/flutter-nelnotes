part of 'search_note_bloc.dart';

sealed class SearchNoteState extends Equatable {}

final class SearchNoteInitial extends SearchNoteState {
  @override
  List<Object?> get props => [];
}

final class SearchNoteLoading extends SearchNoteState {
  @override
  List<Object?> get props => [];
}

final class SearchNoteLoaded extends SearchNoteState {
  final List<NoteModel> note;
  SearchNoteLoaded({required this.note});
  @override
  List<Object?> get props => [note];
}

final class SearchNoteError extends SearchNoteState {
  @override
  List<Object?> get props => [];
}
