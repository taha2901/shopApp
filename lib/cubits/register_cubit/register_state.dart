part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class ShopRegisterInitial extends RegisterState {}

final class ShopRegisterLoaded extends RegisterState {}

final class ShopRegisterSuccess extends RegisterState {
  final ShopLoginModel registerModel;

  ShopRegisterSuccess({required this.registerModel});
}


final class ShopRegisterFailure extends RegisterState {
  final String errMessage;

  ShopRegisterFailure(this.errMessage);
}

final class RegisterchangePasswordVisibility extends RegisterState {}
