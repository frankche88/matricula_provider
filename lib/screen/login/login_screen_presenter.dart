import 'package:flutter/widgets.dart';
import 'package:matricula_provider/infraestructure/Sqflite_UserRepository.dart';
import 'package:matricula_provider/model/user.dart';
import 'package:matricula_provider/data/database_helper.dart';
import 'package:matricula_provider/data/rest_ds.dart';


enum AuthState { LOGGED_IN, LOGGED_OUT, AUTHENTICATING }

abstract class LoginScreenContract {
  void onLoginSuccess(User user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter with ChangeNotifier {

  static final LoginScreenPresenter _instance = new LoginScreenPresenter.internal();

  factory LoginScreenPresenter() => _instance;

  LoginScreenPresenter.internal(){
    //_subscribers = new List<AuthStateListener>();
    initState();
  }

  void initState() async{
    print("InitState AuthStateProvider");
  }

//class LoginScreenPresenter {
 // LoginScreenContract _view;
  RestDatasource api = new RestDatasource();
  //LoginScreenPresenter(this._view);
  //LoginScreenPresenter();

  SqfliteUserRepository userRepository =
    SqfliteUserRepository(DatabaseHelper.get);

  AuthState _authState = AuthState.LOGGED_OUT;

  AuthState get status => _authState;

  Future<bool> doLogin(String username, String password, String email) async {

    try {
      _authState = AuthState.AUTHENTICATING;
      User user = await api.login(username, password, email);
    
    
      return processLoginSuccess(user);

      //return true;
        
    }catch (e){
      _authState = AuthState.LOGGED_OUT;
      notifyListeners();
      return false;
    }

      


  }

  Future<bool> processLoginSuccess(User user) async {
      var loggedInUser = await userRepository.login(user);
      if (loggedInUser != null) {
        //_view.onLoginSuccess(user);
        this._authState = AuthState.LOGGED_IN;
        notifyListeners();
        return true;
      }
      else {
        //_view.onLoginError("Invalid credentials");
        this._authState = AuthState.LOGGED_OUT;
        notifyListeners();
        return false;
      }
  }
}