part of 'validasi_search_bloc.dart';

class ValidasiSearchState extends Equatable {
  final bool isShowButtonClear;
  const ValidasiSearchState({required this.isShowButtonClear});

  @override
  List<Object> get props => [isShowButtonClear];
}
