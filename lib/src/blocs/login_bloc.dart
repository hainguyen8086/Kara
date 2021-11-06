import 'dart:async';

import 'package:kara/src/validators/validations.dart';

class LoginBloc {
  StreamController _userController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get userStream => _userController.stream;
  Stream get passStream => _passController.stream;

  bool isValidInfo(String username, String pass) {
    if (!Validations.isValidUser(username)) {
      _userController.sink.addError("Tai khoan khong hop le");
      return false;
    }
    _userController.sink.add("OK_USER");

    if (!Validations.isValidPass(pass)) {
      _passController.sink.addError("Mat khau phai tren 6 ki tu");
      return false;
    }
    _passController.sink.add("OK_PASS");

    return true;
  }

  void dispose() {
    _userController.close();
    _passController.close();
  }
}
