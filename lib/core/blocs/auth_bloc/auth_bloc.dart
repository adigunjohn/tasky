import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app/config/locator.dart';
import 'package:tasky/core/models/user.dart';
import 'package:tasky/core/repositories/auth_repository.dart';
import 'package:tasky/core/services/storage_service.dart';
import 'package:tasky/utils/extensions.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = locator<AuthRepository>();
  final StorageService _storageService = locator<StorageService>();


  AuthBloc() : super(const AuthState()) {
    on<LoadUser>(_loadUser);
    on<Login>(_login);
    on<Register>(_register);
    on<Logout>(_logout);
    on<TogglePasswordVisibility>(_togglePasswordVisibility);
  }


  void _loadUser(LoadUser event, Emitter<AuthState> emit){
   final user = _storageService.getUserFromHive();
   if(user == null) return;
   emit(state.copyWith(user: user));
  }


  Future<void> _login(Login event, Emitter<AuthState> emit) async{
    try{
      emit(state.copyWith(loginStatus: AuthLoginStatus.loading, registerStatus: AuthRegisterStatus.initial));
      final user = await _authRepository.login(email: event.email, password: event.password);
      emit(state.copyWith(user: user, loginStatus: AuthLoginStatus.success, successMessage: 'Login successful'));
    }
    catch(e){
      emit(state.copyWith(loginStatus: AuthLoginStatus.failure, errorMessage: e.toString().preciseErrorMessage));
    }
  }


  Future<void> _register(Register event, Emitter<AuthState> emit) async{
    try{
      emit(state.copyWith(registerStatus: AuthRegisterStatus.loading, loginStatus: AuthLoginStatus.initial));
      final user = await _authRepository.register(name: event.name, email: event.email, password: event.password);
      emit(state.copyWith(user: user, registerStatus: AuthRegisterStatus.success, successMessage: 'Signup successful'));
    }
    catch(e){
      emit(state.copyWith(registerStatus: AuthRegisterStatus.failure, errorMessage: e.toString().preciseErrorMessage));
    }
  }


  void _logout(Logout event, Emitter<AuthState> emit) async{
    await _storageService.deleteToken();
    await _storageService.clearLoggedInHive();
    await _storageService.clearUserInHive();
    await _storageService.clearTasksInHive();
    await _storageService.clearThemeSettingsInHive();
    emit(const AuthState());
  }


  void _togglePasswordVisibility(TogglePasswordVisibility event, Emitter<AuthState> emit){
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

}