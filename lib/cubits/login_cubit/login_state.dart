part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoaded extends LoginState {}

final class LoginSuccess extends LoginState {
  final ShopLoginModel loginModel;

  LoginSuccess(this.loginModel);
}

final class LoginFailure extends LoginState {
  final String errMessage;

  LoginFailure(this.errMessage);
}

final class LoginchangePasswordVisibility extends LoginState {}