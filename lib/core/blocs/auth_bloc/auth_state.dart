part of 'auth_bloc.dart';

enum AuthRegisterStatus { initial, loading, success, failure }
enum AuthLoginStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthRegisterStatus registerStatus;
  final AuthLoginStatus loginStatus;
  final String? errorMessage;
  final String? successMessage;
  final User? user;
  final bool passwordVisible;



  const AuthState({
    this.loginStatus = AuthLoginStatus.initial,
    this.registerStatus = AuthRegisterStatus.initial,
    this.errorMessage,
    this.successMessage,
    this.user,
    this.passwordVisible = false
  });

  AuthState copyWith({
    AuthRegisterStatus? registerStatus,
    AuthLoginStatus? loginStatus,
    String? errorMessage,
    String? successMessage,
    User? user,
    bool? passwordVisible,
  }){
    return AuthState(
      registerStatus: registerStatus ?? this.registerStatus,
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      user: user ?? this.user,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }

  @override
  List<Object?> get props => [registerStatus, errorMessage, successMessage, user, loginStatus, passwordVisible];
  }

