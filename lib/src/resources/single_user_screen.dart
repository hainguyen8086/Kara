import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kara/src/model/res-data-user-zalo.dart';
import 'package:kara/src/model/single_user_reponse.dart';
import 'package:kara/src/model/user.dart';
import 'package:kara/src/services/authen_service.dart';
import 'package:kara/src/services/dio_services.dart';
import 'package:kara/src/services/http_service.dart';
import 'package:kara/src/services/service_zalopay.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleUserScreen extends StatefulWidget {
  @override
  _SingleUserScreenState createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {
  late HttpService http;
  // late Dio dio;
  late ServiceZaloPay serviceZaloPay;
  late AuthenServices authenServices;
  // late Dio dio2;

  late SingleUserResponse singleUserResponse;
  late ResDataUserZalo resDataUserZalo;

  // late User user;

  bool isLoading = false;

  Future getUser() async {
    Response response;
    try {
      isLoading = true;

      response = await http.getRequest("/api/users/2");

      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          singleUserResponse = SingleUserResponse.fromJson(response.data);
          // user = singleUserResponse.user;
        });
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  Future getUserZalo() async {
    Response response;
    try {
      response =
          await serviceZaloPay.getUser("/api/integration/v1/ZaloPay/user");
      if (response.statusCode == 200) {
        setState(() {
          resDataUserZalo = ResDataUserZalo.fromJson(response.data);
        });
      } else {
        print("There is some problem status code not 200");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future getAccessToken() async {
    Response response;
    try {
      response = await authenServices.authen("/api/auth");
      // response = await authenServices.authen("/connect/token");
      // if (response.statusCode == 200) {
      //   setState(() {
      //     resDataUserZalo = ResDataUserZalo.fromJson(response.data);
      //   });
      // } else {
      //   print("There is some problem status code not 200");
      // }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    http = HttpService();
    serviceZaloPay = ServiceZaloPay();
    authenServices = AuthenServices();

    getUser();
    // getUserZalo();
    // getAccessToken();
    // setDataPrefer();
    ServicesDio().testAPI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Single user"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : singleUserResponse.user != null
              // : user != null
              ? Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(singleUserResponse.user.avatar),
                      // Image.network(user.avatar),
                      Container(
                        height: 16,
                      ),
                      Text(
                          "Hello, ${singleUserResponse.user.firstName} ${singleUserResponse.user.lastName}")
                      // Text("Hello, ${user.firstName} ${user.lastName}")
                    ],
                  ),
                )
              : Center(child: Text("No User Object")),
    );
  }

  void setDataPrefer() async {
    print('save dataFirst to dat1');
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

// set value
    prefs.setString('dat1', 'dataFirst');
    print('save dataFirst to dat1');
  }
}
