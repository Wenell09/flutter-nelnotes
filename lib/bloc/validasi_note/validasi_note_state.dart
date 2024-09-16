part of 'validasi_note_bloc.dart';

sealed class ValidasiNoteState extends Equatable {}

final class ValidasiNoteInitial extends ValidasiNoteState {
  final bool isValidate;
  final bool isSuccess;
  ValidasiNoteInitial({required this.isValidate, required this.isSuccess});

  @override
  List<Object?> get props => [isValidate, isSuccess];
}
