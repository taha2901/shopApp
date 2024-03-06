import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/Network/end_points.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/helper/api.dart';
import 'package:shopapp/models/shop_login.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(ShopRegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    ShopLoginModel registerModel;
    emit(ShopRegisterLoaded());
    DioHelper().postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
      registerModel = ShopLoginModel.fromjson(value.data);
      emit(ShopRegisterSuccess(registerModel: registerModel));
      printFullText(registerModel.toString());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopRegisterFailure(onError.toString()));
    });
  }

  bool isObsecure = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isObsecure = !isObsecure;
    suffix =
        isObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterchangePasswordVisibility());
  }
}
