import 'package:flutter_app6/models/user_model.dart';

abstract class appStates {

}

class stateInitiale extends appStates {

}


class stateLoginLoading extends appStates {

}

class stateLoginSuccess extends appStates {
  final UserModel? userModel;
  final UserData? userData;
  stateLoginSuccess(this.userModel,this.userData);
}

class stateLoginError extends appStates {
  final String error;
  stateLoginError(this.error);
}


class stateChangeBottomNav extends appStates {

}


class stateHomeSuccess extends appStates {

}

class stateHomeError extends appStates {

}


class stateCategoriesSuccess extends appStates {

}

class stateCategoriesError extends appStates {

}


class stateFavoritesSuccess extends appStates {

}

class stateFavoritesError extends appStates {

}


class stateChangeFavorites extends appStates {

}


class stateGetProfile extends appStates {

}

class stateGetProfileError extends appStates {

}


class stateChangePassLoading extends appStates {

}

class stateChangePassSuccess extends appStates {
  final UserModel? passwordModel;
  stateChangePassSuccess(this.passwordModel);
}

class stateChangePassError extends appStates {

}


class stateEditProfileLoading extends appStates {

}

class stateEditProfileSuccess extends appStates {
  final UserModel? editProfile;
  stateEditProfileSuccess(this.editProfile);
}

class stateEditProfileError extends appStates {

}


class stateSearchLoading extends appStates {

}

class stateSearchSuccess extends appStates {

}

class stateSearchError extends appStates {

}