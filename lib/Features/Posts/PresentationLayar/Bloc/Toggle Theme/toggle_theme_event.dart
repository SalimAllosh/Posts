part of 'toggle_theme_bloc.dart';

abstract class ToggleThemeEvent extends Equatable {
  const ToggleThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeClickedEvent extends ToggleThemeEvent {}
