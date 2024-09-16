part of 'search_note_bloc.dart';

sealed class SearchNoteEvent extends Equatable {}

class SearchNote extends SearchNoteEvent {
  final String userId, title;
  SearchNote({required this.userId, required this.title});

  @override
  List<Object?> get props => [userId, title];
}
