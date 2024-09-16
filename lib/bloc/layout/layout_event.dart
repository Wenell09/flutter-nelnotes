part of 'layout_bloc.dart';

sealed class LayoutEvent extends Equatable {}

class LayoutLoad extends LayoutEvent {
  @override
  List<Object?> get props => [];
}

class LayoutSave extends LayoutEvent {
  @override
  List<Object?> get props => [];
}
