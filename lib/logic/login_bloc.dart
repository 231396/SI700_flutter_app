
import 'package:flutter_app/data/database_local.dart';
import 'package:flutter_app/logic/login_bloc_event.dart';
import 'package:flutter_app/logic/login_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
	LoginScreenBloc() : super(LoginScreenState(person: null));

	@override
	Stream<LoginScreenState> mapEventToState(LoginScreenEvent event) async* {
		if(event is LoginEvent)
		{
			var loginPerson = await DatabaseLocal.helper.getPersonByLogin(event.person.email, event.person.email);
			yield new LoginScreenState(person: loginPerson);
		}
		else if (event is SingupEvent)
		{
			var personList = await DatabaseLocal.helper.getAllPerson();
			bool exist = false;
			for (var i = 0; i < personList.length; i++) {
				if(personList[i].email == event.person.email)
					exist = true;
			}
			if(!exist){
				await DatabaseLocal.helper.insertPerson(event.person);
				yield new LoginScreenState(person: event.person);
			}
			yield new LoginScreenState(person: null);
		}
	}
}
