import 'dart:async';
import 'package:kara/src/validators/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsBloc {
  StreamController _prefsController = new StreamController();
  Stream get prefs => _prefsController.stream;

  Future<String> getDat1() {
    _prefsController.sink.add("OK_PREFS");
    Future<String> data1 = Validations.prefsDat1('dat1');
    return data1;
  }

  void dispose() {
    _prefsController.close();
  }
}
