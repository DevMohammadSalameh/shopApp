abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String Error;
  LoginErrorState(this.Error);
}

class LoginChangePasswordVisibilityState extends LoginStates {}