part of 'validasi_note_bloc.dart';

sealed class ValidasiNoteEvent extends Equatable {}

class ValidasiNote extends ValidasiNoteEvent {
  final String title, deskripsi;
  ValidasiNote({
    required this.title,
    required this.deskripsi,
  });

  @override
  List<Object> get props => [title, deskripsi];
}

class ValidasiNoteEnd extends ValidasiNoteEvent {
  @override
  List<Object?> get props => [];
}
