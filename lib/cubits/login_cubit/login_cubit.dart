import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopapp/Network/end_points.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/helper/api.dart';
import 'package:shopapp/models/shop_login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  void userLogin({required String email, required String password}) {
    ShopLoginModel loginModel;
    emit(LoginLoaded());
    DioHelper().postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromjson(value.data);
      printFullText(loginModel.toString());
      emit(LoginSuccess(loginModel));
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginFailure(onError.toString()));
    });
  }

  bool isObsecure = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isObsecure = !isObsecure;
    suffix =
        isObsecure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginchangePasswordVisibility());
  }
}
