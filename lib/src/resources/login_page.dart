import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kara/src/blocs/login_bloc.dart';
import 'package:kara/src/resources/single_user_screen.dart';
import 'package:kara/src/services/dio_services.dart';
import 'package:kara/src/services/login_kara_services.dart';
import 'package:kara/src/validators/validations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc = new LoginBloc();
  bool _showPass = false;
  late LoginKaraService loginKaraService;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _token;

  Future<void> _setTokenStorage(String newToken) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('token', newToken);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
  }

  void test() async {
    String result = await ServicesDio().testAPI();
    print("result = $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                  child: FlutterLogo()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                "Hello \nWellcom My Kara",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: StreamBuilder(
                    stream: loginBloc.userStream,
                    builder: (context, snapshot) => TextField(
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          controller: _userController,
                          decoration: InputDecoration(
                              labelText: "USERNAME",
                              errorText: snapshot.hasError
                                  ? snapshot.error.toString()
                                  : null,
                              labelStyle: TextStyle(
                                  color: Color(0xff888888), fontSize: 15)),
                        ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: [
                    StreamBuilder(
                        stream: loginBloc.passStream,
                        builder: (context, snapshot) => TextField(
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              controller: _passController,
                              obscureText: !_showPass,
                              decoration: InputDecoration(
                                  labelText: "PASSWORD",
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : "",
                                  labelStyle: TextStyle(
                                      color: Color(0xff888888), fontSize: 15)),
                            )),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Text(
                        _showPass ? "HIDE" : "SHOW",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: TextField(
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "OTP",
                    labelStyle:
                        TextStyle(color: Color(0xff888888), fontSize: 15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  onPressed: onSignInClicked,
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Container(
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      "FORGOT PASSWORD",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future login() async {
    Response response;
    loginKaraService = LoginKaraService();
    try {
      response = await loginKaraService.getToken("/api/auth");
      // if (response.statusCode == 200) {
      //   setState(() {
      //     resDataUserZalo = ResDataUserZalo.fromJson(response.data);
      //   });
      // } else {
      //   print("There is some problem status code not 200");
      // }
      print("loginok");
    } on Exception catch (e) {
      print(e);
    }
  }

  void onSignInClicked() async {
    String res = await ServicesDio().testAPI();
    print(res);
    setState(() {
      print('on Click SignIn');
      // loginKaraService = LoginKaraService();
      // print(Validations.prefsDat1('dat1'));
      // login();
      // var data = {'username': 'admin', 'password': '123456'};
      // loginKaraService.postFormData(
      //     "https://blooming-depths-89692.herokuapp.com/api/auth", data);
      // if (loginBloc.isValidInfo(
      //     _userController.text.toString(), _passController.text.toString())) {
      //   Navigator.push(context,
      //       MaterialPageRoute(builder: (context) => SingleUserScreen()));
      // }
    });
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  Widget gotoHome(BuildContext context) {
    return SingleUserScreen();
  }
}
