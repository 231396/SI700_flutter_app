
import 'package:flutter_app/data/database_web_server.dart';
import 'package:flutter_app/logic/singup/singup_bloc_event.dart';
import 'package:flutter_app/logic/singup/singup_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingupBloc extends Bloc<SingupEvent, SingupState> {
	SingupBloc() : super(SingupFailState());

	@override
	Stream<SingupState> mapEventToState(SingupEvent event) async* {
		var personList = await DatabaseWebServer.helper.getAllPerson();
		bool exist = false;
		for (var i = 0; i < personList.length; i++) {
			if(personList[i].email == event.person.email)
				exist = true;
		}
		if(!exist){
			await DatabaseWebServer.helper.insertPerson(event.person);
			yield new SingupSucessState(person: event.person);
		}
		else
			yield new SingupFailState();
	}
}
