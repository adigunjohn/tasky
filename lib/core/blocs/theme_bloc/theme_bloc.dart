import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/core/repositories/theme_repository.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>{
  final ThemeRepository _themeRepository = locator<ThemeRepository>();
  ThemeBloc() : super(const ThemeState()){
    on<ToggleTheme>(_toggleTheme);
    on<LoadSavedTheme>(loadSavedTheme);
    on<ClearTheme>(clearTheme);
  }


  void _toggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    final newMode = state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _themeRepository.setThemeMode(newMode);
    emit(state.copyWith(themeMode: newMode));
  }


  void loadSavedTheme(LoadSavedTheme event, Emitter<ThemeState> emit){
    final newMode = _themeRepository.getThemeMode() ?? ThemeMode.light;
    emit(state.copyWith(themeMode: newMode));
  }


  void clearTheme(ClearTheme event, Emitter<ThemeState> emit){
    emit(const ThemeState());
  }
}