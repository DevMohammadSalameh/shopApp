// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/register/cubit/register_states.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/end_points.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  late UserModel registerModel;
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String name,
    required dynamic phone,
    required String password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
      lang: 'er',
    ).then((value) {
      registerModel = UserModel.fromJson(value.data);
      // print(value.data.toString());
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      emit(RegisterErrorState(error));
      print(error.toString());
    });
  }

  IconData passwordIcon = Icons.remove_red_eye;
  bool isPassword = true;

  void changePasswordState() {
    isPassword = !isPassword;
    passwordIcon = isPassword ? Icons.remove_red_eye : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }
}
