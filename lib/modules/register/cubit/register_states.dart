import 'package:shop_app/models/user_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  late UserModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates {
  final Error;
  RegisterErrorState(this.Error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}