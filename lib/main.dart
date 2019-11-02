import 'package:flutter/material.dart';
import 'package:matricula_provider/routes.dart';
import 'package:provider/provider.dart';
import 'package:matricula_provider/screen/login/login_screen_presenter.dart';
import 'package:matricula_provider/common/app_constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider (
        builder: (_) => LoginScreenPresenter(),
        child: MaterialApp(
          title: AppConstants.appTitle,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Roboto",
            primarySwatch: AppConstants.primaryColor,
          ),
          routes: routes,
        ),
     );
  }
}
