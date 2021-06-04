import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thread_app/models/user.dart';
import 'package:thread_app/services/user_service.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthService authenticationService;

  UserBloc({this.authenticationService}) : assert(authenticationService != null), super(AuthenticateInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (event is AuthenticationInit) {      
      yield AuthLoading();
      try {
        final String token = prefs.getString('token');        
        final User currentUser = await authenticationService.getCurrentUser(token);
        yield AuthSuccess(user: currentUser);
      } catch (err) {        
        yield AuthFailure(message: err);
        yield LoginInitial();
      }     
    } 

    if (event is LoginTry) {      
      yield AuthLoading();
      try {
        final User currentUser = await authenticationService.login(event.phone, event.password);
        await prefs.setString('token', currentUser.token);        
        yield AuthSuccess(user: currentUser);
      } catch (err) {           
        yield AuthFailure(message: err);
        yield LoginInitial();
      }
    }

    if (event is RegisterTry) {      
      yield AuthLoading();
      try {
        final User currentUser = await authenticationService.register(event.phone, event.username, event.password);
        await prefs.setString('token', currentUser.token);
        yield AuthSuccess(user: currentUser);
      } catch (err) {
        yield AuthFailure(message: err);
        yield RegisterInitial();
      }
    }

    if (event is UserLoggedOut) {
      await authenticationService.signOut();
      await prefs.remove('token');
      yield AuthBreak();
    }
  }  
}

