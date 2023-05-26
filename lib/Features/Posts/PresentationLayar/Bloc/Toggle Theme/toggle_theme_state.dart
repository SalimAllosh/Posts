part of 'toggle_theme_bloc.dart';

abstract class ToggleThemeState extends Equatable {
  const ToggleThemeState();

  @override
  List<Object> get props => [];
}

class ToggleThemeInitial extends ToggleThemeState {}

class ToggleThemeClickedState extends ToggleThemeState {
  final bool toggle;

  const ToggleThemeClickedState({required this.toggle});

  @override
  List<Object> get props => [toggle];
}
