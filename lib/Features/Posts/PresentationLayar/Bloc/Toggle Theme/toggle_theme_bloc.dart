// ignore_for_file: unnecessary_type_check

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'toggle_theme_event.dart';
part 'toggle_theme_state.dart';

class ToggleThemeBloc extends Bloc<ToggleThemeEvent, ToggleThemeState> {
  bool toggle = true;

  ToggleThemeBloc() : super(ToggleThemeInitial()) {
    on<ToggleThemeEvent>((event, emit) {
      if (event is ToggleThemeEvent) {
        toggle = !toggle;

        emit(ToggleThemeClickedState(toggle: toggle));
      }
    });
  }
}
