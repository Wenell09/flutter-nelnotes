part of 'detail_note_bloc.dart';

sealed class DetailNoteState extends Equatable {}

final class DetailNoteInitial extends DetailNoteState {
  @override
  List<Object?> get props => [];
}

final class DetailNoteLoading extends DetailNoteState {
  @override
  List<Object?> get props => [];
}

final class DetailNoteLoaded extends DetailNoteState {
  final List<NoteModel> detailNote;
  DetailNoteLoaded({required this.detailNote});
  @override
  List<Object?> get props => [detailNote];
}

final class DetailNoteError extends DetailNoteState {
  final String error;
  DetailNoteError({required this.error});
  @override
  List<Object?> get props => [error];
}
