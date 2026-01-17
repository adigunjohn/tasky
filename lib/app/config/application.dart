import 'package:flutter/material.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/core/services/storage_service.dart';

class Application {
  static Future<void> initializeApp() async{
    WidgetsFlutterBinding.ensureInitialized();
    await StorageService.initializeHive();
    setupLocator();
  }
}

