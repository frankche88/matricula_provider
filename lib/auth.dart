

//enum AuthState { LOGGED_IN, LOGGED_OUT, AUTHENTICATING }

// enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }


class AuthStateProvider{
  // static final AuthStateProvider _instance = new AuthStateProvider.internal();

  // List<AuthStateListener> _subscribers;

  // factory AuthStateProvider() => _instance;

  // AuthStateProvider.internal(){
  //   _subscribers = new List<AuthStateListener>();
  //   initState();
  // }

  // void initState() async{
  //   print("InitState AuthStateProvider");
  // }

  // void subscribe(AuthStateListener listener) {
  //   _subscribers.add(listener);
  // }

  // void dispose(AuthStateListener listener){
  //   for (var l in _subscribers){
  //     if (l == listener)
  //       _subscribers.remove(l);
  //   }
  // }

  // void notify(AuthState state){
  //   _subscribers.forEach((AuthStateListener s) => s.onAuthStateChanged(state));
  // }
}