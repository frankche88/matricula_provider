import 'dart:async';
import 'package:matricula_provider/utils/network_utils.dart';
import 'package:matricula_provider/model/user.dart';

class RestDatasource{
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://www.mocky.io/v2/5b3a39632e0000bd13158154";

  Future<User> login(String username, String password, String email){
    return _netUtil.post(BASE_URL,body: {
      "username": username,
      "password": password
    }).then((dynamic res) {
      print (res.toString());
      return new User(username,password,username);
    });
  }
}