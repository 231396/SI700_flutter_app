
import 'package:flutter_app/data/database_web_server.dart';
import 'package:flutter_app/logic/login/login_bloc_event.dart';
import 'package:flutter_app/logic/login/login_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
	LoginBloc() : super(LoginFailState());

	@override
	Stream<LoginState> mapEventToState(LoginEvent event) async* {
		var loginPerson = await DatabaseWebServer.helper.getPersonByLogin(event.person.email, event.person.password);
		if(loginPerson != null)
			yield new LoginSucessState(person: loginPerson);
		else
			yield new LoginFailState();
	}
}
