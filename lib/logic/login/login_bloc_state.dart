
import 'package:flutter_app/model/person.dart';

abstract class LoginState {}

class LoginFailState extends LoginState {}

class LoginSucessState extends LoginState {
	Person person;
	LoginSucessState({this.person});
}