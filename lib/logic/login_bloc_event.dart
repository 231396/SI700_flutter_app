
import 'package:flutter_app/model/person.dart';

abstract class LoginScreenEvent {}

class SingupEvent extends LoginScreenEvent {
	Person person;
	SingupEvent({this.person});
}

class LoginEvent extends LoginScreenEvent {
	Person person;
	LoginEvent({this.person});
}