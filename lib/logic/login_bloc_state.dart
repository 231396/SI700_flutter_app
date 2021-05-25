
import 'package:flutter_app/model/person.dart';

class LoginScreenState {
	Person person;
	LoginScreenState({this.person});
}


class LoginScreenLoginState extends LoginScreenState {}

class LoginScreenSingupState extends LoginScreenState {}