part of 'layout_bloc.dart';

class LayoutState extends Equatable {
  final bool isGrid;
  const LayoutState({required this.isGrid});
  @override
  List<Object?> get props => [isGrid];
}
