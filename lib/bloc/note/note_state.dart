part of 'note_bloc.dart';

sealed class NoteState extends Equatable {}

final class NoteInitial extends NoteState {
  @override
  List<Object?> get props => [];
}

final class NoteLoading extends NoteState {
  @override
  List<Object?> get props => [];
}

final class NoteLoaded extends NoteState {
  final List<NoteModel> notes;
  NoteLoaded({required this.notes});
  @override
  List<Object?> get props => [notes];
}

final class NoteError extends NoteState {
  final String error;
  NoteError({required this.error});
  @override
  List<Object?> get props => [error];
}

final class NoteAddSuccess extends NoteState {
  final String userId;
  NoteAddSuccess({required this.userId});
  @override
  List<Object?> get props => [userId];
}

final class NoteEditSuccess extends NoteState {
  final String userId;
  NoteEditSuccess({required this.userId});
  @override
  List<Object?> get props => [userId];
}

final class NoteDeleteSuccess extends NoteState {
  @override
  List<Object?> get props => [];
}
