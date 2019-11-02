import 'package:flutter/material.dart';
import 'package:matricula_provider/screen/login/login_screen.dart';
import 'package:matricula_provider/screen/home/home_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new HomeScreen(),
  '/' :          (BuildContext context) => new LoginScreen(),
};