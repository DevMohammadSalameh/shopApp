// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/login_states.dart';

import '../../../netwoek/remote/dio_helper.dart';
import '../../../shared/network/end_points.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    },lang: 'er').then((value) {
      emit(LoginSuccessState());
      print(value.data.toString());
    }).catchError((error){
      emit(LoginErrorState(error));
      print(error.data.toString());
    });
  }

  IconData  passwordIcon = Icons.remove_red_eye;
  bool isPassword = true;

  void changePasswordState(){
    isPassword = !isPassword;
    passwordIcon = isPassword? Icons.remove_red_eye : Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }
}
