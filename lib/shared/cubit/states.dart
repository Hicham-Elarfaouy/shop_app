import 'package:flutter_app6/models/user_model.dart';

abstract class appStates {

}

class stateInitiale extends appStates {

}

class stateLoginLoading extends appStates {

}

class stateLoginSuccess extends appStates {
  final UserModel? userModel;
  stateLoginSuccess(this.userModel);
}

class stateLoginError extends appStates {
  final String error;
  stateLoginError(this.error);
}