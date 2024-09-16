part of 'validasi_search_bloc.dart';

sealed class ValidasiSearchEvent extends Equatable {}

class ShowButtonClear extends ValidasiSearchEvent {
  final String title;
  ShowButtonClear({required this.title});

  @override
  List<Object?> get props => [title];
}

class ClearInput extends ValidasiSearchEvent {
  @override
  List<Object?> get props => [];
}
