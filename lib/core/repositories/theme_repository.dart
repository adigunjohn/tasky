import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/core/services/storage_service.dart';
import 'package:tasky/utils/constants.dart';

class ThemeRepository{
  final StorageService _storageService = locator<StorageService>();

  void logInfo(String info){
    log('${AppConstants.themeRepoLog}$info');
  }

  ThemeMode? getThemeMode(){
    try{
      final themeMode = _storageService.getThemeModeFromHive();
      return themeMode;
    }catch(e){
      logInfo('Failed to get themeMode: $e');
      throw Exception('Failed to get themeMode: $e');
    }
  }


  Future<void> setThemeMode(ThemeMode theme) async{
    try{
      await _storageService.updateThemeModeToHive(theme: theme);
    }catch(e){
      logInfo('Failed to set themeMode: $e');
      throw Exception('Failed to set themeMode: $e');
    }
  }


  Future<void> clearSavedThemeMode() async{
    try{
      await _storageService.clearThemeSettingsInHive();
    }catch(e){
      logInfo('Failed to clear themeMode: $e');
      throw Exception('Failed to delete themeMode: $e');
    }
  }
}