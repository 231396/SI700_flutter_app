
import 'package:flutter_app/data/database_local.dart';
import 'package:flutter_app/logic/login/login_bloc_event.dart';
import 'package:flutter_app/logic/login/login_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
	LoginBloc() : super(LoginFailState());

	@override
	Stream<LoginState> mapEventToState(LoginEvent event) async* {
		var loginPerson = await DatabaseLocal.helper.getPersonByLogin(event.person.email, event.person.password);
		if(loginPerson.length > 0)
			yield new LoginSucessState(person: loginPerson[0]);
		else
			yield new LoginFailState();
	}
}
