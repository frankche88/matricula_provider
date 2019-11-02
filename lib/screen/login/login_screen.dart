import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:matricula_provider/common/app_constants.dart';
import 'package:matricula_provider/screen/login/login_screen_presenter.dart';
import 'package:matricula_provider/model/user.dart';

class 
LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
implements LoginScreenContract
{
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password,_email = "frank.che88@gmail.com";

  LoginScreenPresenter _presenter;

  LoginScreenState(){
    //_presenter = new LoginScreenPresenter(this);
    //var authStateProvider = new AuthStateProvider();
    //authStateProvider.subscribe(this);
  }

  void _submit() async {
    final form = formKey.currentState;
    if (form.validate()) {
      //setState(()=> _isLoading=true);

      form.save();

      var logged = await _presenter.doLogin(_username,_password,_email);

      if (!logged) {
        onLoginError("Invalid credentials");
      } else {
        //onLoginError("Invalid credentials");
        Navigator.of(_ctx).pushReplacementNamed("/home");
      }

      //_presenter.doLogin(_username,_password,_email);
    }
  }

  void _showSnackBar(String text){
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(text)));
  }

  //@override
  void onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed("/home");
    if (state == AuthState.LOGGED_OUT)
      Navigator.of(_ctx).pushReplacementNamed("/");
  }

  @override
  Widget build(BuildContext context){
    _ctx = context;
    _presenter = Provider.of<LoginScreenPresenter>(context);
    _isLoading = (_presenter.status == AuthState.AUTHENTICATING);
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("LOGIN"),
      color: Colors.primaries[0],
    );

    var loginForm = new Column(
      children: <Widget>[
        new Text(
          AppConstants.appTitle,
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  validator: (val){
                    return val.length < 5
                      ? "Username must have at least 5 chars"
                      : null;
                  },
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  obscureText: true,
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Password"),
                ),
              ),
            ],
          ),
        ),
        _isLoading ? new CircularProgressIndicator(): loginBtn
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage('assets/login_background.jpg'),
            fit: BoxFit.cover
          ),
        ),
        child: new Center(
          child: new ClipRect(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                child: loginForm,
                height: 300.0,
                width: 300.0,
                decoration: new BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.5)),
                ),
              ),
            ),
          ),
        ),
      );
  }

  @override
  void onLoginError(String errorTxt){
    _showSnackBar(errorTxt);
    //setState(()=> _isLoading = false);
  }

  @override
  void onLoginSuccess(User user) async{
    _showSnackBar(user.toString());
    //setState(()=> _isLoading = false);
    //var authStateProvider = new AuthStateProvider();
    //authStateProvider.notify(AuthState.LOGGED_IN);
  }

}

