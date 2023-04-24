import 'package:shop_app/models/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  late UserModel loginModel;

  LoginSuccessState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final Error;
  LoginErrorState(this.Error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}