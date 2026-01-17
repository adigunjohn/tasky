import 'dart:developer';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/core/models/user.dart';
import 'package:tasky/core/services/network_service.dart';
import 'package:tasky/core/services/storage_service.dart';
import 'package:tasky/utils/constants.dart';

class AuthRepository {
  final NetworkService _networkService = locator<NetworkService>();
  final StorageService _storageService = locator<StorageService>();


  void logInfo(String info){
    log('${AppConstants.authRepoLog}$info');
  }


  Future<User> login({required String email, required String password}) async {
    try{
      logInfo('Logging in user');
      final response = await _networkService.post(
          AppConstants.loginEndpoint,
          headers: AppConstants.header,
          body: {
            'email': email,
            'password': password,
          });

      final token = response['authToken'];
      if(token == null) logInfo('Token is null');
      await _storageService.storeToken(token);

      final data = response['user'];
      if(data == null) logInfo('Data is null');
      await _storageService.updateUserToHive(user: User.fromJson(data));
      await _storageService.updateLoggedInToHive(loggedIn: true);
      return User.fromJson(data);
    }
    catch(e){
      logInfo('Login failed: $e');
      if(e.toString().contains('403')) throw Exception('Incorrect email or password');
      rethrow;
    }
  }



  Future<User> register({required String name, required String email, required String password}) async {
    try{
      logInfo('Registering user');
      final response = await _networkService.post(
          AppConstants.registerEndpoint,
          headers: AppConstants.header,
          body: {
            'name': name,
            'email': email,
            'password': password,
          });

      final token = response['authToken'];
      if(token == null) logInfo('Token is null');
      await _storageService.storeToken(token);

      final data = response['user'];
      if(data == null) logInfo('Data is null');
      await _storageService.updateUserToHive(user: User.fromJson(data));
      await _storageService.updateLoggedInToHive(loggedIn: true);
      return User.fromJson(data);
    }
    catch(e){
      logInfo('Registration failed: $e');
      if(e.toString().contains('403')) throw Exception('This email is already registered');
      rethrow;
    }
  }


}
